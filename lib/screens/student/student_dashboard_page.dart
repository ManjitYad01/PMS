import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';
import '../student/student_index_page.dart';

class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<DocumentSnapshot> _joinedClassrooms = [];

  @override
  void initState() {
    super.initState();
    _fetchJoinedClassrooms();
  }

  Future<void> _fetchJoinedClassrooms() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(uid)
        .collection('joinedClassrooms')
        .get();
    setState(() {
      _joinedClassrooms = snapshot.docs;
    });
  }

  Future<void> _requestToJoinClassroom(DocumentSnapshot classroom) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final studentDoc = await FirebaseFirestore.instance.collection('students').doc(uid).get();
    final rollNo = studentDoc['rollNo'];
    final teamsId = studentDoc['teamsId'];
    print('Student rollNo: $rollNo, teamsId: $teamsId');

    final classroomStudentsSnapshot = await FirebaseFirestore.instance
        .collection('classrooms')
        .doc(classroom.id)
        .collection('students')
        .get();

    print('Classroom students count: ${classroomStudentsSnapshot.docs.length}');
    bool matchFound = false;
    for (var doc in classroomStudentsSnapshot.docs) {
      final data = doc.data();
      print('Checking classroom student: ${data['rollNo']} / ${data['teamsId']}');
      if (data['rollNo'] == rollNo || data['teamsId'] == teamsId) {
        matchFound = true;
        break;
      }
    }

    if (matchFound) {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .collection('joinedClassrooms')
          .doc(classroom.id)
          .set({'classroomName': classroom['name']});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have joined "${classroom['name']}".')),
      );
      _fetchJoinedClassrooms();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient permission to enter this classroom.')),
      );
    }
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
      Navigator.pop(context);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? 'Student';

    return WillPopScope(
      onWillPop: () => _confirmLogout(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Dashboard'),
          backgroundColor: AppColors.brickRed,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // TODO: Show notifications
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Classroom',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _searchQuery.isEmpty
                    ? _buildJoinedClassroomsList()
                    : _buildSearchResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('classrooms')
          .where('name', isGreaterThanOrEqualTo: _searchQuery)
          .where('name', isLessThanOrEqualTo: _searchQuery + '\uf8ff')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final classrooms = snapshot.data!.docs;
        if (classrooms.isEmpty) {
          return const Center(child: Text('No classrooms found.'));
        }
        return ListView.builder(
          itemCount: classrooms.length,
          itemBuilder: (context, index) {
            final classroom = classrooms[index];
            return ExpansionTile(
              title: Text(classroom['name'] ?? ''),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _requestToJoinClassroom(classroom),
                    child: const Text('Request to Join'),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildJoinedClassroomsList() {
    if (_joinedClassrooms.isEmpty) {
      return const Center(child: Text('No classrooms joined yet.'));
    }
    return ListView.builder(
      itemCount: _joinedClassrooms.length,
      itemBuilder: (context, index) {
        final classroom = _joinedClassrooms[index];
        return ExpansionTile(
          title: Text(classroom['classroomName'] ?? ''),
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('classrooms')
                  .doc(classroom.id)
                  .collection('subjects')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final subjects = snapshot.data!.docs;
                if (subjects.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No subjects found.'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subjects.length,
                  itemBuilder: (context, subIndex) {
                    final subject = subjects[subIndex];
                    return ListTile(
                      title: Text(subject['name'] ?? ''),
                      onTap: () async {
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        final studentDoc = await FirebaseFirestore.instance
                          .collection('classrooms')
                          .doc(classroom.id)
                          .collection('students')
                          .doc(uid)
                          .get();
                        final studentData = studentDoc.data() as Map<String, dynamic>? ?? {};
                        final batchNo = studentData['batch'] ?? 0;
                        final studentName = studentData['name'] ?? '';
                        final semester = subject['semester'] ?? '';
                        final subjectName = subject['name'] ?? '';

                        final classroomData = classroom.data() as Map<String, dynamic>? ?? {};
                        final classroomName = classroomData['classroomName'] ?? classroomData['name'] ?? '';

                        if (!studentData.containsKey('name')) {
                          print('Student document missing "name" field');
                        }
                        if (!classroomData.containsKey('name')) {
                          print('Classroom document missing "name" field');
                        }
                        final subjectData = subject.data() as Map<String, dynamic>? ?? {};
                        if (!subjectData.containsKey('name')) {
                          print('Subject document missing "name" field');
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StudentIndexPage(
                              studentId: uid,
                              classroomId: classroom.id,
                              subjectId: subject.id,
                              batchNo: batchNo,
                              semester: semester,
                              studentName: studentName,
                              subjectName: subjectName,
                              classroomName: classroomName,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
