import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';
import '../../utils/loading.dart';

class PendingApprovalsScreen extends StatelessWidget {
  const PendingApprovalsScreen({super.key});

  Future<void> _approveTeacher(BuildContext context, String uid) async {
    showLoading(context);
    try {
      await FirebaseFirestore.instance.collection('teachers').doc(uid).update({
        'approved': true,           // keep old flag for compatibility
        'status': 'approved',       // new status field
      });
      Navigator.pop(context); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teacher approved successfully.')),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error approving teacher: $e')),
      );
    }
  }

  Future<void> _rejectTeacher(BuildContext context, String uid) async {
    showLoading(context);
    try {
      // Instead of deleting, mark as rejected
      await FirebaseFirestore.instance.collection('teachers').doc(uid).update({
        'approved': false,
        'status': 'rejected',
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teacher rejected successfully.')),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error rejecting teacher: $e')),
      );
    }
  }

  void _showActionDialog(BuildContext context, String action, String uid) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$action Confirmation'),
        content: Text('Are you sure you want to $action this teacher?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (action == 'Approve') {
                _approveTeacher(context, uid);
              } else {
                _rejectTeacher(context, uid);
              }
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Approvals'),
        backgroundColor: AppColors.brickRed,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('teachers')
            .where('status', isEqualTo: 'pending') // <-- updated query
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No pending approvals.'));
          }

          final teachers = snapshot.data!.docs;

          return Scrollbar(
            thickness: 8,
            radius: const Radius.circular(10),
            thumbVisibility: true,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                final teacher = teachers[index];
                final isEven = index % 2 == 0;

                return ExpansionTile(
                  backgroundColor: isEven ? AppColors.beige : AppColors.lightBrick,
                  title: Text(
                    teacher['name'] ?? 'Unnamed',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    ListTile(
                      title: Text('UID: ${teacher['uid']}'),
                      subtitle: Text('Email: ${teacher['email']}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 8,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                          overlayColor: AppColors.beige.withOpacity(0.3),
                          activeTrackColor: AppColors.brickRed,
                          inactiveTrackColor: AppColors.beige,
                        ),
                        child: Slider(
                          value: 0.5,
                          onChanged: (_) {},
                          onChangeEnd: (value) {
                            if (value <= 0.25) {
                              _showActionDialog(context, 'Reject', teacher.id);
                            } else if (value >= 0.75) {
                              _showActionDialog(context, 'Approve', teacher.id);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
