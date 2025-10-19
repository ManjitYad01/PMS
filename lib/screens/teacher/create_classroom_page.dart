import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/colors.dart';
import '../../utils/loading.dart';

class CreateClassroomPage extends StatefulWidget {
  final String teacherUid; // your custom teacher code (e.g., SIES001)
  const CreateClassroomPage({super.key, required this.teacherUid});

  @override
  State<CreateClassroomPage> createState() => _CreateClassroomPageState();
}

class _CreateClassroomPageState extends State<CreateClassroomPage> {
  final _classroomNameController = TextEditingController();
  int? _selectedBatch;
  String? _selectedTeacherId;
  List<Map<String, String>> _approvedTeachers = [];
  List<Map<String, String>> _addedTeachers = [];
  PlatformFile? _studentListFile;

  @override
  void initState() {
    super.initState();
    _fetchApprovedTeachers();
  }

  Future<void> _fetchApprovedTeachers() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .where('status', isEqualTo: 'approved')
          .get();

      setState(() {
        _approvedTeachers = snapshot.docs
            .map((doc) => {
                  'uid': doc.id,
                  'name': (doc['name'] as String?) ?? 'Unnamed',
                })
            .where((t) => t['uid'] != widget.teacherUid)
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load approved teachers: $e')),
      );
    }
  }

  Future<void> _pickExcelFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      setState(() => _studentListFile = result.files.single);
    }
  }

  // ✅ Corrected parse to match: SrNo | Name | Roll No | Teams ID
  Future<List<Map<String, dynamic>>> _parseStudentExcel(Uint8List bytes) async {
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables[excel.tables.keys.first]!;
    final students = <Map<String, dynamic>>[];

    for (final row in sheet.rows.skip(1)) {
      final name = row[1]?.value?.toString().trim();
      final roll = row[2]?.value?.toString().trim();
      final teamsId = row[3]?.value?.toString().trim();
      if (roll != null && name != null && teamsId != null) {
        students.add({'rollNo': roll, 'name': name, 'teamsId': teamsId});
      }
    }
    return students;
  }

  List<Map<String, dynamic>> _assignBatches(
      List<Map<String, dynamic>> students, int numBatches) {
    final baseSize = students.length ~/ numBatches;
    final remainder = students.length % numBatches;
    int batch = 1, count = 0;
    for (int i = 0; i < students.length; i++) {
      students[i]['batch'] = batch;
      count++;
      final maxForBatch = baseSize + (batch <= remainder ? 1 : 0);
      if (count >= maxForBatch && batch < numBatches) {
        batch++;
        count = 0;
      }
    }
    return students;
  }

  Future<void> _createClassroom() async {
    final name = _classroomNameController.text.trim();
    final batchCount = _selectedBatch;
    final sharedWith = _addedTeachers.map((t) => t['uid']).toList();
    final currentUser = FirebaseAuth.instance.currentUser;

    if (name.isEmpty || batchCount == null || _studentListFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and attach the student list.')),
      );
      return;
    }
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in.')),
      );
      return;
    }

    showLoading(context);
    try {
      final rawStudents = await _parseStudentExcel(_studentListFile!.bytes!);
      final studentsWithBatch = _assignBatches(rawStudents, batchCount);

      final teachersArray = <String>{widget.teacherUid, ...sharedWith.cast<String>()}.toList();

      final classroomRef =
          await FirebaseFirestore.instance.collection('classrooms').add({
        'name': name,
        'batch': batchCount,
        'createdByAuthUid': currentUser.uid,
        'createdByTeacherUid': widget.teacherUid,
        'sharedWith': sharedWith,
        'teachers': teachersArray,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final studentsColl = classroomRef.collection('students');
      for (final s in studentsWithBatch) {
        await studentsColl.add(s);
      }

      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Classroom & students added!')),
      );

      _classroomNameController.clear();
      setState(() {
        _selectedBatch = null;
        _addedTeachers.clear();
        _studentListFile = null;
      });
    } catch (e) {
      hideLoading(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Classroom'), backgroundColor: AppColors.brickRed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name of the Classroom'),
            const SizedBox(height: 5),
            TextField(
              controller: _classroomNameController,
              decoration: const InputDecoration(
                hintText: 'Eg: FYCS, SYCS',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Number of Batches'),
            DropdownButtonFormField<int>(
              value: _selectedBatch,
              items: List.generate(4, (i) => i + 1)
                  .map((num) => DropdownMenuItem<int>(
                        value: num,
                        child: Text('$num'),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedBatch = v),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            const Text('Share With (Teachers)'),
            DropdownButtonFormField<String>(
              value: _selectedTeacherId,
              items: _approvedTeachers
                  .map((t) => DropdownMenuItem<String>(
                        value: t['uid']!,
                        child: Text('${t['name']} (${t['uid']})'),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedTeacherId = v),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _selectedTeacherId == null
                  ? null
                  : () {
                      if (_addedTeachers.any((t) => t['uid'] == _selectedTeacherId)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Teacher already added')),
                        );
                        return;
                      }
                      final t = _approvedTeachers
                          .firstWhere((x) => x['uid'] == _selectedTeacherId);
                      setState(() {
                        _addedTeachers.add({'uid': t['uid']!, 'name': t['name']!});
                        _selectedTeacherId = null;
                      });
                    },
              icon: const Icon(Icons.person_add),
              label: const Text('Add Teacher'),
            ),
            const SizedBox(height: 10),
            if (_addedTeachers.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _addedTeachers
                    .map((t) => ListTile(
                          title: Text('${t['name']} (${t['uid']})'),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () => setState(
                                () => _addedTeachers.removeWhere((x) => x['uid'] == t['uid'])),
                          ),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 20),
            const Text('Attach student list to be admitted'),
            OutlinedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: Text(_studentListFile?.name ?? 'Attach Excel File'),
              onPressed: _pickExcelFile,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _createClassroom,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brickRed,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(child: Text('Create')),
            ),
          ],
        ),
      ),
    );
  }
}
