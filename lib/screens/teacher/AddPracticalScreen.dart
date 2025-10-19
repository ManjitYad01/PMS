import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';

class AddPracticalScreen extends StatefulWidget {
  final String classroomId;
  final String subjectId;
  final int batchNo;

  const AddPracticalScreen({
    super.key,
    required this.classroomId,
    required this.subjectId,
    required this.batchNo,
  });

  @override
  State<AddPracticalScreen> createState() => _AddPracticalScreenState();
}

class _AddPracticalScreenState extends State<AddPracticalScreen> {
  final _titleController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _selectedDate;

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _savePractical() async {
    if (_titleController.text.trim().isEmpty ||
        _startTime == null ||
        _endTime == null ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all fields")),
      );
      return;
    }

    final dateStr = "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}";
    final startStr = "${_startTime!.hour}:${_startTime!.minute.toString().padLeft(2, '0')}";
    final endStr = "${_endTime!.hour}:${_endTime!.minute.toString().padLeft(2, '0')}";

    await FirebaseFirestore.instance
        .collection('classrooms')
        .doc(widget.classroomId)
        .collection('subjects')
        .doc(widget.subjectId)
        .collection('batches')
        .doc(widget.batchNo.toString())
        .collection('practicals')
        .add({
      'title': _titleController.text.trim(),
      'date': dateStr,
      'startTime': startStr,
      'endTime': endStr,
      'createdAt': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Practical"), backgroundColor: AppColors.brickRed),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Practical Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickDate,
                child: Text(_selectedDate == null
                    ? "Pick Date"
                    : "Date: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}"),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _pickTime(true),
                      child: Text(_startTime == null
                          ? "Pick Start Time"
                          : "Start: ${_startTime!.format(context)}"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _pickTime(false),
                      child: Text(_endTime == null
                          ? "Pick End Time"
                          : "End: ${_endTime!.format(context)}"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brickRed,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _savePractical,
                child: const Text("Save Practical"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}