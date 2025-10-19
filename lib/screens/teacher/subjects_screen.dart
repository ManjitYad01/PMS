import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'batches_screen.dart';

class SubjectsScreen extends StatefulWidget {
  final String classroomId; // comes from TeacherDashboard
  const SubjectsScreen({super.key, required this.classroomId});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final _auth = FirebaseAuth.instance;
  final _subjectNameController = TextEditingController();
  String _selectedSemester = 'I';

  final List<String> _semesters = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'];

  Future<void> _addSubject() async {
    final name = _subjectNameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a subject name")),
      );
      return;
    }

    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in.")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('classrooms')
          .doc(widget.classroomId)
          .collection('subjects')
          .add({
        'name': name,
        'semester': _selectedSemester,
        'createdByAuthUid': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.pop(context); // close dialog
        _subjectNameController.clear();
        setState(() {
          _selectedSemester = 'I';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _showAddSubjectDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Subject"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _subjectNameController,
              decoration: const InputDecoration(
                hintText: "Enter subject name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedSemester,
              decoration: const InputDecoration(
                labelText: 'Semester',
                border: OutlineInputBorder(),
              ),
              items: _semesters.map((sem) {
                return DropdownMenuItem(
                  value: sem,
                  child: Text(sem),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedSemester = val!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _addSubject,
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Subjects"),
        backgroundColor: AppColors.brickRed,
      ),
      body: user == null
          ? const Center(child: Text("You must be logged in."))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('classrooms')
                  .doc(widget.classroomId)
                  .collection('subjects')
                  .where('createdByAuthUid', isEqualTo: user.uid)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(
                    child: Text("No subjects yet. Add one!"),
                  );
                }

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final subjectId = docs[index].id;
                    final subjectName = data['name'] ?? "Unnamed Subject";
                    return ListTile(
                      title: Text(subjectName),
                      subtitle: data['semester'] != null
                          ? Text('Semester: ${data['semester']}')
                          : null,
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BatchesScreen(
                              classroomId: widget.classroomId,
                              subjectId: subjectId,
                              subjectName: subjectName,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSubjectDialog,
        backgroundColor: AppColors.brickRed,
        child: const Icon(Icons.add),
      ),
    );
  }
}