// authentication.dart
import 'package:dasa/features/Onboarding/models/user_model.dart';
import 'package:dasa/features/dashboard/views/all_forms.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthApi {
  late LoginData loginData;

  Future<bool> signIn(
      BuildContext context, String email, String password) async {
    var apiUrl = 'https://360dasa.org/dasaapis/index.php/DasaApi';

    var response = await http.post(
      Uri.parse('$apiUrl/dasaLogin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email_address': email,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      loginData = LoginData(
        error: responseData["error"],
        token: responseData["token"],
        message: responseData["message"] ?? '',
        userData: UserData.fromJson(responseData['data'] ?? {}),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyForms(),
        ),
      );
      return true;
    } else {
      print('Response status: ${response.statusCode}');
      // Handle error cases
      return false;
    }
  }

  static Future<void> signUp(BuildContext context, String title,
      String firstName, String lastName, String email, String password) async {
    var apiUrl = 'https://360dasa.org/dasaapis/index.php/DasaApi';

    var response = await http.post(
      Uri.parse('$apiUrl/createAccount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'title': title,
          'first_name': firstName,
          'last_name': lastName,
          'email_address': email,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Account Created Successfully'),
          content: const Text('Your account has been successfully created.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyForms()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      if (response.statusCode == 400 &&
          response.body.contains('Email already exists')) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Email Already in Use'),
            content: const Text('The provided email is already in use.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred while signing up.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}
