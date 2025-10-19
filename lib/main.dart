import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Required for Firebase initialization

import 'constants/colors.dart';
import 'screens/login/login_main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PracticalManagementSystem());
}


class PracticalManagementSystem extends StatelessWidget {
  const PracticalManagementSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIES Practical Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.beige,
        primaryColor: AppColors.brickRed,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.brickRed,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brickRed,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      home: const LoginMainPage(),
    );
  }
}
