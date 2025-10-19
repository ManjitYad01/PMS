import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';

class AssignmentSubmissionScreen extends StatefulWidget {
  final String classroomId;
  final String subjectId;
  final int batchNo;
  final String practicalId;

  const AssignmentSubmissionScreen({
    super.key,
    required this.classroomId,
    required this.subjectId,
    required this.batchNo,
    required this.practicalId,
  });

  @override
  State<AssignmentSubmissionScreen> createState() => _AssignmentSubmissionScreenState();
}

class _AssignmentSubmissionScreenState extends State<AssignmentSubmissionScreen> {
  Map<String, bool?> submission = {}; // studentId -> true/false/null

  Future<void> _saveSubmission() async {
    final practicalRef = FirebaseFirestore.instance
        .collection('classrooms')
        .doc(widget.classroomId)
        .collection('subjects')
        .doc(widget.subjectId)
        .collection('batches')
        .doc(widget.batchNo.toString())
        .collection('practicals')
        .doc(widget.practicalId);

    final practicalDoc = await practicalRef.get();
    final data = practicalDoc.data() as Map<String, dynamic>? ?? {};
    final existingAssignmentSubmittedMap = Map<String, dynamic>.from(data['assignmentSubmitted'] ?? {});

    // Merge current submissions with existing ones
    final updatedAssignmentSubmittedMap = {...existingAssignmentSubmittedMap};
    submission.forEach((studentId, isSubmitted) {
      if (isSubmitted != null) {
        updatedAssignmentSubmittedMap[studentId] = isSubmitted;
      }
    });

    await practicalRef.set({
      'assignmentSubmitted': updatedAssignmentSubmittedMap,
      'assignmentSaved': true,
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Submission status saved!")),
    );
    Navigator.pop(context); // Pops back to PracticalsScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignment Submission"), backgroundColor: AppColors.brickRed),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('classrooms')
            .doc(widget.classroomId)
            .collection('students')
            .where('batch', isEqualTo: widget.batchNo)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final students = snapshot.data!.docs;

          // Initialize submission map
          for (var doc in students) {
            final studentId = doc.id;
            if (!submission.containsKey(studentId)) {
              submission[studentId] = null;
            }
          }

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Roll nos')),
                    DataColumn(label: Text('Submitted - Yes')),
                    DataColumn(label: Text('Submitted - No')),
                  ],
                  rows: students.map((doc) {
                    final data = doc.data() as Map<String, dynamic>? ?? {};
                    final rollNo = data['rollNo']?.toString() ?? 'N/A';
                    final studentId = doc.id;
                    return DataRow(cells: [
                      DataCell(Text(rollNo)),
                      DataCell(Checkbox(
                        value: submission[studentId] == true,
                        onChanged: (val) {
                          setState(() {
                            submission[studentId] = true;
                          });
                        },
                      )),
                      DataCell(Checkbox(
                        value: submission[studentId] == false,
                        onChanged: (val) {
                          setState(() {
                            submission[studentId] = false;
                          });
                        },
                      )),
                    ]);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSubmission,
                child: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brickRed,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}