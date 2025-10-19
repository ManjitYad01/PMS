import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/colors.dart';

class StudentIndexWidget extends StatelessWidget {
  final String studentId;
  final String classroomId;
  final String subjectId;
  final int batchNo;
  final String semester;
  final String studentName;
  final String subjectName;
  final String classroomName;

  const StudentIndexWidget({
    super.key,
    required this.studentId,
    required this.classroomId,
    required this.subjectId,
    required this.batchNo,
    required this.semester,
    required this.studentName,
    required this.subjectName,
    required this.classroomName,
  });

  @override
  Widget build(BuildContext context) {
    final batch = batchNo.toString();

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('classrooms')
          .doc(classroomId)
          .collection('students')
          .doc(studentId)
          .get(),
      builder: (context, studentSnapshot) {
        if (!studentSnapshot.hasData) return const Center(child: CircularProgressIndicator());
        final studentData = studentSnapshot.data!.data() as Map<String, dynamic>? ?? {};
        print('Student batch: $batch');

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('classrooms').doc(classroomId).get(),
          builder: (context, classroomSnapshot) {
            if (!classroomSnapshot.hasData) return const Center(child: CircularProgressIndicator());
            final classroomData = classroomSnapshot.data!.data() as Map<String, dynamic>? ?? {};
            final classroomName = classroomData['name'] ?? '';

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('classrooms')
                  .doc(classroomId)
                  .collection('subjects')
                  .doc(subjectId)
                  .get(),
              builder: (context, subjectSnapshot) {
                if (!subjectSnapshot.hasData) return const Center(child: CircularProgressIndicator());
                final subjectData = subjectSnapshot.data!.data() as Map<String, dynamic>? ?? {};
                final subjectName = subjectData['name'] ?? '';

                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('classrooms')
                      .doc(classroomId)
                      .collection('subjects')
                      .doc(subjectId)
                      .collection('batches')
                      .doc(batch)
                      .collection('practicals')
                      .get(),
                  builder: (context, practicalsSnapshot) {
                    print('Fetching practicals for batch: $batch');
                    if (!practicalsSnapshot.hasData) return const Center(child: CircularProgressIndicator());
                    final practicals = practicalsSnapshot.data!.docs;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header fills horizontally
                          Card(
                            elevation: 2,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Student Name: $studentName', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Class: $classroomName'),
                                  Text('Subject: $subjectName'),
                                  Text('Batch: $batch'),
                                  Text('Semester: $semester'),
                                  const Text('Marks: ', style: TextStyle(fontWeight: FontWeight.bold)), // leave empty for now
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Table
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Sr.No')),
                                  DataColumn(label: Text('Title')),
                                  DataColumn(label: Text('Assignment')),
                                  DataColumn(label: Text('Attendance')),
                                ],
                                rows: List.generate(practicals.length, (index) {
                                  final practical = practicals[index].data() as Map<String, dynamic>? ?? {};
                                  final title = practical['title'] ?? '';
                                  // Fetch assignment and attendance status for this student
                                  final assignmentStatus = practical['assignmentSubmitted']?[studentId] == true;
                                  final attendanceStatus = practical['attendanceMarked']?[studentId] == true;
                                  return DataRow(cells: [
                                    DataCell(Text('${index + 1}')),
                                    DataCell(Text(title)),
                                    DataCell(
                                      Icon(
                                        assignmentStatus ? Icons.check_circle : Icons.cancel,
                                        color: assignmentStatus ? Colors.green : Colors.red,
                                      ),
                                    ),
                                    DataCell(
                                      Icon(
                                        attendanceStatus ? Icons.check_circle : Icons.cancel,
                                        color: attendanceStatus ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ]);
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}