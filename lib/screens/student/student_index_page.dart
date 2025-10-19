import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/student_index_widget.dart';
import 'dart:developer' as logger;
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentIndexPage extends StatelessWidget {
  final String studentId;
  final String classroomId;
  final String subjectId;
  final int batchNo;
  final String semester;
  final String studentName;
  final String subjectName;
  final String classroomName;

  const StudentIndexPage({
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Index'),
        backgroundColor: AppColors.brickRed,
      ),
      body: StudentIndexWidget(
        studentId: studentId,
        classroomId: classroomId,
        subjectId: subjectId,
        batchNo: batchNo,
        semester: semester,
        studentName: studentName,
        subjectName: subjectName,
        classroomName: classroomName,
      ),
    );
  }
}