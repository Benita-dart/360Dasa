//import 'package:dasa/features/Onboarding/views/signin.dart';
//import 'package:dasa/features/Onboarding/views/welcome.dart';
import 'package:dasa/common/widgets/colors.dart';
import 'package:dasa/features/Onboarding/views/sign_up.dart';
import 'package:dasa/features/Onboarding/views/welcome.dart';
import 'package:dasa/features/dashboard/views/all_forms.dart';
//import 'package:dasa/features/Onboarding/views/sign_up.dart';
//import 'package:dasa/features/Onboarding/views/signup.dart';
//import 'package:dasa/features/Onboarding/views/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
      home: WelcomeScreen(),
    );
  }
}
