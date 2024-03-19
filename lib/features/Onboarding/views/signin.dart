import 'package:dasa/common/widgets/colors.dart';
import 'package:dasa/common/widgets/text.dart';
import 'package:dasa/features/Onboarding/API%20Calls/signin_api.dart';
import 'package:dasa/features/Onboarding/views/sign_up.dart';
import 'package:dasa/features/dashboard/views/all_forms.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isError = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      bool success = await AuthApi.signIn(context, email, password);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyForms(),
          ),
        );
      } else {
        print('Login failed');
        if (email.isEmpty || password.isEmpty) {
          setState(() {
            _isError = true;
          });
        }
      }
    } catch (e) {
      print('Error: $e');
      print('Login error: ${e.toString()}');
    } finally {
      setState(() {
        // Hide loader
      });
    }
  }

  //   if (email.isEmpty || password.isEmpty) {
  //     setState(() {
  //       _isError = true;
  //     });
  //     return;
  //   }

  //   AuthApi.signIn(context, email, password);
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.primaryColor, Color(0xFFF6FEFF)],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.25),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                height: screenHeight,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, top: screenHeight * 0.08),
                      child: const Text(
                        'Sign In',
                        style: AppTextStyles.mainText,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: buildTextField('Email Address', _emailController),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: buildTextField(
                          'Enter Password', _passwordController,
                          isPassword: true),
                    ),
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Center(
                      child: SizedBox(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.75,
                        child: ElevatedButton(
                          onPressed: _signIn,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                          ),
                          child: const Text(
                            'Sign In',
                            style: AppTextStyles.midText,
                          ),
                        ),
                      ),
                    ),
                    if (_isError)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            Text(
                              'Please fill in all fields',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'No account yet?',
                          style: TextStyle(
                            fontFamily: 'KaiseiOpti',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ),
                            );
                          },
                          child: const Text('Create Account'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.primaryColor), // Set focused border color
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
