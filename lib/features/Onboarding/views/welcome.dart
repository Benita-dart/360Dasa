import 'package:dasa/common/widgets/colors.dart';
import 'package:dasa/common/widgets/text.dart';
import 'package:dasa/features/Onboarding/views/sign_up.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF17A2B8), Color(0xFFF6FEFF)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 180,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Welcome to 360 Dasa',
                  style: TextStyle(
                    fontFamily: 'KaiseiOpti',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.feedback,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Create feedback forms',
                        style: AppTextStyles.midText,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.poll,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Create Polls', style: AppTextStyles.midText),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.data_array,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Create Database',
                        style: AppTextStyles.midText,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor),
                    ),
                    child: const Text(
                      'Get Started',
                      style: AppTextStyles.midText,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
