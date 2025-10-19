import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'admin_login_page.dart';
import 'teacher_login_page.dart';
import 'student_login_page.dart';

class LoginMainPage extends StatelessWidget {
  const LoginMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // College Logo
              Image.asset(
                'assets/images/sies_logo.png', // make sure the logo exists in assets
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              
              const Text(
                'Login as',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brickRed,
                ),
              ),
              const SizedBox(height: 30),

              // Admin Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AdminLoginPage()),
                    );
                  },
                  child: const Text('Admin'),
                ),
              ),
              const SizedBox(height: 15),

              // Teacher Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TeacherLoginPage()),
                    );
                  },
                  child: const Text('Teacher'),
                ),
              ),
              const SizedBox(height: 15),

              // Student Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const StudentLoginPage()),
                    );
                  },
                  child: const Text('Student'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
