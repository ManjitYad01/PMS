import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';
import 'PracticalAttendanceScreen.dart';
import 'AssignmentSubmissionScreen.dart';
import 'AddPracticalScreen.dart';

class PracticalsScreen extends StatelessWidget {
  final String classroomId;
  final String subjectId;
  final int batchNo;

  const PracticalsScreen({
    super.key,
    required this.classroomId,
    required this.subjectId,
    required this.batchNo,
  });

  @override
  Widget build(BuildContext context) {
    final practicalsRef = FirebaseFirestore.instance
        .collection('classrooms')
        .doc(classroomId)
        .collection('subjects')
        .doc(subjectId)
        .collection('batches')
        .doc(batchNo.toString())
        .collection('practicals')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Practicals - Batch $batchNo"),
        backgroundColor: AppColors.brickRed,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: practicalsRef,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Practicals added yet",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final practicals = snapshot.data!.docs;

          return ListView.builder(
            itemCount: practicals.length,
            itemBuilder: (context, index) {
              final doc = practicals[index];
              final practical = doc.data() as Map<String, dynamic>? ?? {};
              final attendanceSaved = practical['attendanceSaved'] == true;
              final assignmentSaved = practical['assignmentSaved'] == true;
              final practicalId = doc.id;

              return ExpansionTile(
                title: Text(practical['title'] ?? ''),
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: attendanceSaved ? Colors.green : Colors.red,
                      radius: 10,
                    ),
                    title: const Text("Practical Attendance"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PracticalAttendanceScreen(
                            classroomId: classroomId,
                            subjectId: subjectId,
                            batchNo: batchNo,
                            practicalId: practicalId,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: assignmentSaved ? Colors.green : Colors.red,
                      radius: 10,
                    ),
                    title: const Text("Assignment Submission"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AssignmentSubmissionScreen(
                            classroomId: classroomId,
                            subjectId: subjectId,
                            batchNo: batchNo,
                            practicalId: practicalId,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddPracticalScreen(
                classroomId: classroomId,
                subjectId: subjectId,
                batchNo: batchNo,
              ),
            ),
          );
        },
        backgroundColor: AppColors.brickRed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
