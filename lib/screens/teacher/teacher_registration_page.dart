import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/colors.dart';
import '../../utils/loading.dart';

class TeacherRegistrationPage extends StatefulWidget {
  const TeacherRegistrationPage({super.key});

  @override
  State<TeacherRegistrationPage> createState() => _TeacherRegistrationPageState();
}

class _TeacherRegistrationPageState extends State<TeacherRegistrationPage> {
  final _uidController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _registerTeacher() async {
    final uid = _uidController.text.trim();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (uid.isEmpty || name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid email address.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    showLoading(context);

    try {
      final auth = FirebaseAuth.instance;

      // Register in Firebase Auth
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store teacher info in Firestore with default status = 'pending'
      await FirebaseFirestore.instance.collection('teachers').doc(uid).set({
        'firebaseUid': userCred.user!.uid,
        'uid': uid,
        'name': name,
        'email': email,
        'approved': false,           // keep for backward compatibility
        'status': 'pending',         // NEW field: pending | approved | rejected
        'createdAt': FieldValue.serverTimestamp(),
      });

      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered successfully. Waiting for admin approval.')),
      );

      // Reset fields
      _uidController.clear();
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();

    } on FirebaseAuthException catch (e) {
      hideLoading(context);
      String errorMsg = 'Registration failed.';
      if (e.code == 'email-already-in-use') {
        errorMsg = 'This email is already registered.';
      } else if (e.code == 'weak-password') {
        errorMsg = 'Password is too weak.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
    } catch (e) {
      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Registration'),
        backgroundColor: AppColors.brickRed,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField('UID', _uidController),
            const SizedBox(height: 20),
            _buildTextField('Full Name', _nameController),
            const SizedBox(height: 20),
            _buildTextField('Email', _emailController),
            const SizedBox(height: 20),
            _buildPasswordField('Password', _passwordController, _obscurePassword, () {
              setState(() => _obscurePassword = !_obscurePassword);
            }),
            const SizedBox(height: 20),
            _buildPasswordField('Confirm Password', _confirmPasswordController, _obscureConfirmPassword, () {
              setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _registerTeacher,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brickRed,
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Register', style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.beige,
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    bool obscureText,
    VoidCallback toggleVisibility,
  ) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.beige,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }
}
