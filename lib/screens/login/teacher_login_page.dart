import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/colors.dart';
import '../../utils/loading.dart';
import '../teacher/teacher_registration_page.dart';
import '../teacher/teacher_forgot_password_page.dart';
import '../teacher/teacher_dashboard_page.dart';
import '../shared/admin_or_teacher_choice_page.dart';

class TeacherLoginPage extends StatefulWidget {
  const TeacherLoginPage({super.key});

  @override
  State<TeacherLoginPage> createState() => _TeacherLoginPageState();
}

class _TeacherLoginPageState extends State<TeacherLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // 👈 toggle variable

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please enter both email and password')));
      return;
    }

    showLoading(context);

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final firebaseUid = credential.user?.uid;
      if (firebaseUid == null) {
        hideLoading(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed: UID not found')),
        );
        return;
      }

      // get custom claims to see if this teacher was promoted to admin
      final idToken = await credential.user!.getIdTokenResult(true);
      final isAdminClaim = idToken.claims?['admin'] == true;

      // get teacher doc for approval status
      final query = await FirebaseFirestore.instance
          .collection('teachers')
          .where('firebaseUid', isEqualTo: firebaseUid)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        hideLoading(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Teacher record not found')));
        return;
      }

      final data = query.docs.first.data();
      final status = (data['status'] ?? '').toString().toLowerCase();
      final approved = data['approved'] ?? (status == 'approved');
      final uid = data['uid'];

      hideLoading(context);

      if (status == 'rejected') {
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your account has been rejected.')),
        );
        return;
      }

      if (isAdminClaim) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                AdminOrTeacherChoicePage(teacherUid: uid, isApproved: approved),
          ),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TeacherDashboardPage(uid: uid, isApproved: approved),
        ),
      );
    } on FirebaseAuthException catch (e) {
      hideLoading(context);
      String msg = 'Login failed';
      if (e.code == 'user-not-found') msg = 'No user found for that email';
      if (e.code == 'wrong-password') msg = 'Incorrect password';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      hideLoading(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Login'), backgroundColor: AppColors.brickRed),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Teacher Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TeacherRegistrationPage()),
                    );
                  },
                  child: const Text('Or Register as New User'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TeacherForgotPasswordPage()),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
