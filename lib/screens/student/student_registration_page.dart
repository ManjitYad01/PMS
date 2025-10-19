import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/colors.dart';
import '../../utils/loading.dart';
import '../login/student_login_page.dart';

class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({super.key});

  @override
  State<StudentRegistrationPage> createState() => _StudentRegistrationPageState();
}

class _StudentRegistrationPageState extends State<StudentRegistrationPage> {
  final _nameController = TextEditingController();
  final _teamsIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _rollNoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final _teamsIdRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@ascs\.sies\.edu\.in$');

  Future<void> _ensureAuthContext() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      try {
        await auth.signInAnonymously();
        debugPrint('[Register] Signed in anonymously for preflight');
      } catch (e) {
        debugPrint('[Register] Anonymous sign-in failed: $e');
        // Proceeding will still work if rules allow public read on teamsIndex (temporary).
      }
    }
  }

  Future<void> _registerStudent() async {
    final name = _nameController.text.trim();
    final teamsIdRaw = _teamsIdController.text.trim();
    final email = _emailController.text.trim();
    final rollNo = _rollNoController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if ([name, teamsIdRaw, email, rollNo, password, confirmPassword].any((e) => e.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }
    if (!_teamsIdRegex.hasMatch(teamsIdRaw)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teams ID must end with @ascs.sies.edu.in')),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final teamsId = teamsIdRaw.toLowerCase();

    showLoading(context);

    // Ensure we have an auth context to satisfy stricter rules if enabled
    await _ensureAuthContext();

    UserCredential? cred;
    final indexRef = FirebaseFirestore.instance.collection('teamsIndex').doc(teamsId);
    bool reserved = false;

    // 0) Preflight existence check (explicit error surfacing on Web)
    try {
      debugPrint('[Register] Preflight existence check for teamsId=$teamsId');
      final preSnap = await indexRef.get();
      if (preSnap.exists) {
        hideLoading(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This Teams ID is already registered.')),
        );
        return;
      }
      debugPrint('[Register] Preflight OK (not exists)');
    } on FirebaseException catch (e, st) {
      debugPrint('[Register][Preflight][FirestoreException] code=${e.code} message=${e.message}\n$st');
      hideLoading(context);
      final msg = (e.code == 'permission-denied')
          ? 'Registration blocked by security rules or auth state. Please sign in or contact support.'
          : 'Reservation preflight failed: ${e.message}';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    } catch (e, st) {
      debugPrint('[Register][Preflight][Unknown] type=${e.runtimeType} error=$e\n$st');
      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reservation preflight failed: $e')));
      return;
    }

    // 1) Reserve Teams ID atomically
    try {
      debugPrint('[Register] Reserving teamsId=$teamsId (txn)');
      await FirebaseFirestore.instance.runTransaction((txn) async {
        final snap = await txn.get(indexRef);
        if (snap.exists) {
          throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'already-exists',
            message: 'teamsId already reserved',
          );
        }
        txn.set(indexRef, {
          'pending': true,
          'createdAt': FieldValue.serverTimestamp(),
        });
      });
      reserved = true;
      debugPrint('[Register] Reservation success (txn)');
    } on FirebaseException catch (e, st) {
      debugPrint('[Register][ReserveTxn][FirestoreException] code=${e.code} message=${e.message}\n$st');
      hideLoading(context);
      final msg = (e.code == 'already-exists')
          ? 'This Teams ID is already registered.'
          : (e.code == 'permission-denied'
              ? 'Registration blocked by security rules. Please contact support.'
              : 'Reservation failed: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    } catch (e, st) {
      debugPrint('[Register][ReserveTxn][Unknown] type=${e.runtimeType} error=$e\n$st');
      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reservation failed: $e')));
      return;
    }

    // 2) Create Auth user
    try {
      debugPrint('[Register] Creating auth user for $email');
      cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('[Register] Auth user created uid=${cred!.user!.uid}');
    } on FirebaseAuthException catch (e, st) {
      debugPrint('[Register][Auth][Exception] code=${e.code} message=${e.message}\n$st');
      if (reserved) {
        try { await indexRef.delete(); } catch (e2, st2) {
          debugPrint('[Register][Rollback] index delete failed: $e2\n$st2');
        }
      }
      hideLoading(context);
      String msg = 'Registration failed.';
      if (e.code == 'email-already-in-use') msg = 'Email already in use.';
      if (e.code == 'weak-password') msg = 'Password is too weak.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    } catch (e, st) {
      debugPrint('[Register][Auth][Unknown] type=${e.runtimeType} error=$e\n$st');
      if (reserved) {
        try { await indexRef.delete(); } catch (_) {}
      }
      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Auth failed: $e')));
      return;
    }

    // 3) Bind reservation to uid
    final uid = cred!.user!.uid;
    try {
      debugPrint('[Register] Binding reservation to uid=$uid');
      await indexRef.update({
        'uid': uid,
        'pending': false,
        'boundAt': FieldValue.serverTimestamp(),
      });
      debugPrint('[Register] Bind success');
    } on FirebaseException catch (e, st) {
      debugPrint('[Register][Bind][FirestoreException] code=${e.code} message=${e.message}\n$st');
      try { await cred!.user!.delete(); } catch (e2, st2) {
        debugPrint('[Register][Rollback] auth delete failed: $e2\n$st2');
      }
      try { await indexRef.delete(); } catch (e2, st2) {
        debugPrint('[Register][Rollback] index delete failed: $e2\n$st2');
      }
      hideLoading(context);
      var msg = 'Registration failed: ${e.message}';
      if (e.code == 'permission-denied') {
        msg = 'Registration blocked by security rules. Please contact support.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    } catch (e, st) {
      debugPrint('[Register][Bind][Unknown] type=${e.runtimeType} error=$e\n$st');
      try { await cred!.user!.delete(); } catch (_) {}
      try { await indexRef.delete(); } catch (_) {}
      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bind failed: $e')));
      return;
    }

    // 4) Create student profile
    try {
      debugPrint('[Register] Creating student profile uid=$uid');
      await FirebaseFirestore.instance.collection('students').doc(uid).set({
        'firebaseUid': uid,
        'name': name,
        'teamsId': teamsId,
        'email': email,
        'rollNo': rollNo,
        'createdAt': FieldValue.serverTimestamp(),
      });
      debugPrint('[Register] Student profile success');
    } on FirebaseException catch (e, st) {
      debugPrint('[Register][Student][FirestoreException] code=${e.code} message=${e.message}\n$st');
      try { await cred!.user!.delete(); } catch (e2, st2) {
        debugPrint('[Register][Rollback] auth delete failed: $e2\n$st2');
      }
      try { await indexRef.delete(); } catch (e2, st2) {
        debugPrint('[Register][Rollback] index delete failed: $e2\n$st2');
      }
      hideLoading(context);
      var msg = 'Registration failed: ${e.message}';
      if (e.code == 'permission-denied') {
        msg = 'Registration blocked by security rules. Please contact support.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    } catch (e, st) {
      debugPrint('[Register][Student][Unknown] type=${e.runtimeType} error=$e\n$st');
      try { await cred!.user!.delete(); } catch (_) {}
      try { await indexRef.delete(); } catch (_) {}
      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile failed: $e')));
      return;
    }

    hideLoading(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registered successfully! Please login.')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const StudentLoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Student Registration'), backgroundColor: AppColors.brickRed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField('Full Name', _nameController),
            const SizedBox(height: 20),
            _buildTextField('College Teams ID', _teamsIdController, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            _buildTextField('Email ID (for login)', _emailController,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            _buildTextField('Full Roll No', _rollNoController),
            const SizedBox(height: 20),
            _buildPasswordField('Create Password', _passwordController, _obscurePassword,
                () => setState(() => _obscurePassword = !_obscurePassword)),
            const SizedBox(height: 20),
            _buildPasswordField('Confirm Password', _confirmPasswordController, _obscureConfirm,
                () => setState(() => _obscureConfirm = !_obscureConfirm)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _registerStudent,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brickRed,
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.beige,
      ),
    );
  }

  Widget _buildPasswordField(
      String label, TextEditingController controller, bool obscure, VoidCallback toggle) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: AppColors.beige,
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
      ),
    );
  }
}
