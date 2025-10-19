import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';
import 'StudentsListScreen.dart';
import 'PracticalsScreen.dart';

class BatchesScreen extends StatelessWidget {
  final String classroomId;
  final String subjectId;
  final String subjectName;

  const BatchesScreen({
    super.key,
    required this.classroomId,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Batches - $subjectName"),
        backgroundColor: AppColors.brickRed,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('classrooms')
            .doc(classroomId)
            .collection('students')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No students found"));
          }
          final students = snapshot.data!.docs;
          // Debug print
          print("Student docs: ${students.map((doc) => doc.data()).toList()}");
          final batches = students
              .map((doc) => doc['batch'])
              .where((batch) => batch != null)
              .toSet()
              .toList()
            ..sort();
          // Debug print
          print("Batches found: $batches");

          if (batches.isEmpty) {
            return const Center(child: Text("No batches found"));
          }

          return ListView.builder(
            itemCount: batches.length,
            itemBuilder: (context, index) {
              final batchNo = batches[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ExpansionTile(
                  title: Text("Batch $batchNo"),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text("List of Students"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StudentsListScreen(
                              classroomId: classroomId,
                              batchNo: batchNo,
                              subjectId: subjectId, // <-- Pass subjectId here
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.book),
                      title: const Text("Practicals"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PracticalsScreen(
                              classroomId: classroomId,
                              subjectId: subjectId,
                              batchNo: batchNo,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}