// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  final bool error;
  final String token;
  final String message;
  final UserData userData;

  LoginData({
    required this.error,
    required this.token,
    required this.message,
    required this.userData,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        error: json["error"],
        token: json["token"],
        message: json["message"],
        userData: UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "token": token,
        "message": message,
        "user_data": userData.toJson(),
      };
}

class UserData {
  final String id;
  final String emailAddress;
  final String firstname;
  final String lastName;
  final DateTime dateCreated;
  final int loggedIn;

  UserData({
    required this.id,
    required this.emailAddress,
    required this.firstname,
    required this.lastName,
    required this.dateCreated,
    required this.loggedIn,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        emailAddress: json["email_address"],
        firstname: json["firstname"],
        lastName: json["last_name"],
        dateCreated: DateTime.parse(json["date_created"]),
        loggedIn: json["logged_in"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email_address": emailAddress,
        "firstname": firstname,
        "last_name": lastName,
        "date_created": dateCreated.toIso8601String(),
        "logged_in": loggedIn,
      };
}
