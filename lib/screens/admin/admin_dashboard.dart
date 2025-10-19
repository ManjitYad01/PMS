import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/colors.dart';
import 'pending_approvals_screen.dart';
import 'teachers_approved_screen.dart';
import 'teachers_rejected_screen.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  Future<bool> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
        ],
      ),
    );
    if (shouldLogout == true) {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context); // back to login page
    }
    return false; // Prevent default back
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _confirmLogout(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          backgroundColor: AppColors.brickRed,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PendingApprovalsScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.beige,
                foregroundColor: AppColors.brickRed,
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Pending Approvals'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TeachersApprovedScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.beige,
                foregroundColor: AppColors.brickRed,
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Teachers Approved'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TeachersRejectedScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.beige,
                foregroundColor: AppColors.brickRed,
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Rejected Teachers'),
            ),
          ],
        ),
      ),
    );
  }
}
