import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';

class TeachersApprovedScreen extends StatelessWidget {
  const TeachersApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers Approved'),
        backgroundColor: AppColors.brickRed,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('teachers')
            .where('approved', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No approved teachers yet.'));
          }

          final approvedTeachers = snapshot.data!.docs;

          return Scrollbar(
            thickness: 8,
            thumbVisibility: true,
            radius: const Radius.circular(10),
            trackVisibility: true,
            interactive: true,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: approvedTeachers.length,
              itemBuilder: (context, index) {
                final teacher = approvedTeachers[index];
                final name = teacher['name'] ?? 'Unnamed';
                final isEven = index % 2 == 0;

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: isEven
                        ? AppColors.beige
                        : AppColors.brickRed.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: isEven ? AppColors.brickRed : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
