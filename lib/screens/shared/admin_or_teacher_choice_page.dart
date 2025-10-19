import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../admin/admin_dashboard.dart';
import '../teacher/teacher_dashboard_page.dart';

class AdminOrTeacherChoicePage extends StatelessWidget {
  final String teacherUid;
  final bool isApproved;

  const AdminOrTeacherChoicePage({
    super.key,
    required this.teacherUid,
    required this.isApproved,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Role'),
        backgroundColor: AppColors.brickRed,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brickRed,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16)),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AdminDashboardPage()),
              ),
              child: const Text('Login as Admin'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.beige,
                  foregroundColor: AppColors.brickRed,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16)),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      TeacherDashboardPage(uid: teacherUid, isApproved: isApproved),
                ),
              ),
              child: const Text('Login as Teacher'),
            ),
          ],
        ),
      ),
    );
  }
}
