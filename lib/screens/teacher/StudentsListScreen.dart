import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../student/student_index_page.dart';
import '../../widgets/student_index_widget.dart';

class StudentsListScreen extends StatelessWidget {
  final String classroomId;
  final int batchNo;
  final String subjectId;

  const StudentsListScreen({
    super.key,
    required this.classroomId,
    required this.batchNo,
    required this.subjectId,
  });

  Future<String> _getSemester() async {
    final subjectDoc = await FirebaseFirestore.instance
        .collection('classrooms')
        .doc(classroomId)
        .collection('subjects')
        .doc(subjectId)
        .get();
    final subjectData = subjectDoc.data() as Map<String, dynamic>? ?? {};
    return subjectData['semester'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    print("classroomId: $classroomId");
    return Scaffold(
      appBar: AppBar(
        title: Text("Batch $batchNo - Students"),
        backgroundColor: AppColors.brickRed,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('classrooms')
            .doc(classroomId)
            .collection('students')
            .where('batch', isEqualTo: batchNo)
            .snapshots(),
        builder: (context, snapshot) {
          print("Looking for students in batch: $batchNo");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print("No students found for batch $batchNo");
            return const Center(
              child: Text(
                "No students in this batch.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final students = snapshot.data!.docs;
          print("Students found: ${students.map((doc) => doc.data()).toList()}");

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index].data() as Map<String, dynamic>;
              final rollNo = student['rollNo'] ?? 'N/A';
              final name = student['name'] ?? 'No Name';

              return ListTile(
                title: Text(
                  "$rollNo - $name",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  // Fetch subject document
                  final subjectDoc = await FirebaseFirestore.instance
                      .collection('classrooms')
                      .doc(classroomId)
                      .collection('subjects')
                      .doc(subjectId)
                      .get();
                  final subjectData = subjectDoc.data() as Map<String, dynamic>? ?? {};
                  final subjectName = subjectData['name'] ?? '';
                  final semester = subjectData['semester'] ?? '';

                  // Fetch classroom document
                  final classroomDoc = await FirebaseFirestore.instance
                      .collection('classrooms')
                      .doc(classroomId)
                      .get();
                  final classroomData = classroomDoc.data() as Map<String, dynamic>? ?? {};
                  final classroomName = classroomData['name'] ?? '';

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentIndexPage(
                        studentId: students[index].id,
                        classroomId: classroomId,
                        subjectId: subjectId,
                        batchNo: batchNo,
                        semester: semester,
                        studentName: name,
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
    );
  }
}