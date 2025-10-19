// teachers_dashboard_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/colors.dart';
import 'create_classroom_page.dart';
import 'subjects_screen.dart';

class TeacherDashboardPage extends StatefulWidget {
  final String uid; // Firebase Auth UID passed from caller
  final bool isApproved;

  const TeacherDashboardPage({
    super.key,
    required this.uid,
    required this.isApproved,
  });

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  int _tapCount = 0;
  String? _collegeId; // e.g., "SIES001"
  bool _loadingProfile = true;

  @override
  void initState() {
    super.initState();
    _loadCollegeId();
  }

  /// Loads the teacher document expected at /teachers/{authUid}.
  /// If not present, attempts to find an existing teacher document
  /// where `firebaseUid == authUid` and copies it to `/teachers/{authUid}`.
  Future<void> _loadCollegeId() async {
    try {
      final teachersCol = FirebaseFirestore.instance.collection('teachers');
      final authUid = widget.uid;

      // 1) Try direct doc read at /teachers/{authUid}
      final docRef = teachersCol.doc(authUid);
      final docSnap = await docRef.get();

      if (docSnap.exists && docSnap.data() != null) {
        final data = docSnap.data()!;
        final cidRaw = (data['collegeId'] ?? data['uid'])?.toString().trim();
        setState(() {
          _collegeId = (cidRaw?.isNotEmpty ?? false) ? cidRaw : null;
          _loadingProfile = false;
        });
        debugPrint('[Dashboard] teacher doc FOUND at teachers/$authUid collegeId=$_collegeId');
        return;
      }

      // 2) Not found at authUid — try to find the record by firebaseUid field
      final query = await teachersCol.where('firebaseUid', isEqualTo: authUid).limit(1).get();
      if (query.docs.isNotEmpty) {
        final found = query.docs.first;
        final data = found.data();
        final cidRaw = (data['collegeId'] ?? data['uid'])?.toString().trim();
        setState(() {
          _collegeId = (cidRaw?.isNotEmpty ?? false) ? cidRaw : null;
        });

        debugPrint('[Dashboard] teacher record found by firebaseUid in ${found.id} — copying to teachers/$authUid');

        // 3) Create a new doc at /teachers/{authUid} copying the fields so server rules that rely on this path succeed.
        // Only create if doc at authUid still doesn't exist (race-check).
        final existing = await docRef.get();
        if (!existing.exists) {
          // Remove any Firestore-managed fields we don't want to copy (if any).
          final copyData = Map<String, dynamic>.from(data);
          // Keep fields such as: uid (college code), firebaseUid, name, status, approved, createdAt, email, etc.
          // Do not copy fields that are sensitive or managed by security rules unless required.
          await docRef.set(copyData);
          debugPrint('[Dashboard] Copied teacher doc into teachers/$authUid');
        }

        if (mounted) setState(() => _loadingProfile = false);
        return;
      }

      // 3) Not found anywhere — no teacher doc exists; UI should handle this.
      debugPrint('[Dashboard] No teacher doc found at teachers/$authUid or by firebaseUid.');
      setState(() {
        _collegeId = null;
        _loadingProfile = false;
      });
    } catch (e, st) {
      debugPrint('[Dashboard] load collegeId/uid failed: $e\n$st');
      if (mounted) setState(() => _loadingProfile = false);
    }
  }

  void _handleFabTap() {
    _tapCount++;
    if (_tapCount == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Double tap to create classroom')),
      );
      Future.delayed(const Duration(milliseconds: 500), () => _tapCount = 0);
    } else if (_tapCount == 2) {
      _tapCount = 0;
      if (!widget.isApproved) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are not approved to create a classroom.')),
        );
        return;
      }
      // Pass Firebase UID to creation flow
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateClassroomPage(teacherUid: widget.uid),
        ),
      );
    }
  }

  Stream<List<QueryDocumentSnapshot>> _classroomsByCollegeId(String collegeId) {
    final base = FirebaseFirestore.instance.collection('classrooms');
    // Composite index needed: teachers (array-contains) + createdAt (desc)
    return base
        .where('teachers', arrayContains: collegeId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs);
  }

  Future<bool> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
        ],
      ),
    );
    if (shouldLogout == true) {
      await FirebaseAuth.instance.signOut();
      if (mounted) Navigator.pop(context);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _confirmLogout(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teacher Dashboard'),
          backgroundColor: AppColors.brickRed,
        ),
        body: _loadingProfile
            ? const Center(child: CircularProgressIndicator())
            : (_collegeId == null
                ? const Center(
                    child: Text('College ID not found in profile. Please contact admin.'),
                  )
                : StreamBuilder<List<QueryDocumentSnapshot>>(
                    stream: _classroomsByCollegeId(_collegeId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        // Fallback: no orderBy (works without composite index)
                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('classrooms')
                              .where('teachers', arrayContains: _collegeId!)
                              .snapshots(),
                          builder: (context, snap2) {
                            if (snap2.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snap2.hasError) {
                              return Center(child: Text('Error: ${snap2.error}'));
                            }
                            final raw = snap2.data?.docs ?? const [];
                            final docs = [...raw];
                            docs.sort((a, b) {
                              final ta = (a.data() as Map<String, dynamic>)['createdAt'];
                              final tb = (b.data() as Map<String, dynamic>)['createdAt'];
                              final da = ta is Timestamp ? ta.toDate() : DateTime.fromMillisecondsSinceEpoch(0);
                              final db = tb is Timestamp ? tb.toDate() : DateTime.fromMillisecondsSinceEpoch(0);
                              return db.compareTo(da);
                            });
                            if (docs.isEmpty) {
                              return Center(
                                child: Text(
                                  'No classrooms shared for ID $_collegeId.',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            }
                            return _buildList(docs);
                          },
                        );
                      }

                      final docs = snapshot.data ?? const [];
                      if (docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No classrooms shared for ID $_collegeId.',
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }
                      return _buildList(docs);
                    },
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleFabTap,
          backgroundColor: AppColors.brickRed,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildList(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final doc = docs[index];
        final data = doc.data() as Map<String, dynamic>;
        final classroomId = doc.id;
        final name = (data['name'] as String?)?.trim().isNotEmpty == true
            ? data['name'] as String
            : 'Unnamed Classroom';
        final createdAtTs = data['createdAt'] as Timestamp?;
        final createdAtStr = createdAtTs != null
            ? createdAtTs.toDate().toLocal().toString()
            : '—';
        return ListTile(
          title: Text(name),
          subtitle: Text('Created at: $createdAtStr'),
          leading: const Icon(Icons.class_),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SubjectsScreen(classroomId: classroomId),
              ),
            );
          },
        );
      },
    );
  }
}
