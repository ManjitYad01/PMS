import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';

class PracticalAttendanceScreen extends StatefulWidget {
  final String classroomId;
  final String subjectId;
  final int batchNo;
  final String practicalId;

  const PracticalAttendanceScreen({
    super.key,
    required this.classroomId,
    required this.subjectId,
    required this.batchNo,
    required this.practicalId,
  });

  @override
  State<PracticalAttendanceScreen> createState() => _PracticalAttendanceScreenState();
}

class _PracticalAttendanceScreenState extends State<PracticalAttendanceScreen> {
  Map<String, bool?> attendance = {}; // studentId -> true/false/null

  Future<void> _saveAttendance() async {
    // Fetch existing attendanceMarked map
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
    final existingAttendanceMarkedMap = Map<String, dynamic>.from(data['attendanceMarked'] ?? {});

    // Update attendanceMarked for all students
    final updatedAttendanceMarkedMap = {...existingAttendanceMarkedMap};
    attendance.forEach((studentId, isPresent) {
      if (isPresent != null) {
        updatedAttendanceMarkedMap[studentId] = isPresent;
      }
    });

    await practicalRef.set({
      'attendanceMarked': updatedAttendanceMarkedMap,
      'attendanceSaved': true,
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Attendance saved!")),
    );
    Navigator.pop(context); // Pops back to PracticalsScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Practical Attendance"), backgroundColor: AppColors.brickRed),
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

          // Initialize attendance map
          for (var doc in students) {
            final studentId = doc.id;
            if (!attendance.containsKey(studentId)) {
              attendance[studentId] = null;
            }
          }

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Roll nos')),
                    DataColumn(label: Text('Present - Yes')),
                    DataColumn(label: Text('Present - No')),
                  ],
                  rows: students.map((doc) {
                    final data = doc.data() as Map<String, dynamic>? ?? {};
                    final rollNo = data['rollNo']?.toString() ?? 'N/A';
                    final studentId = doc.id;
                    return DataRow(cells: [
                      DataCell(Text(rollNo)),
                      DataCell(Checkbox(
                        value: attendance[studentId] == true,
                        onChanged: (val) {
                          setState(() {
                            attendance[studentId] = true;
                          });
                        },
                      )),
                      DataCell(Checkbox(
                        value: attendance[studentId] == false,
                        onChanged: (val) {
                          setState(() {
                            attendance[studentId] = false;
                          });
                        },
                      )),
                    ]);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAttendance,
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