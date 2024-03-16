import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<void> saveUserDetails(String email, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("email", email);
    await instance.setString("password", password);
    log("User details saved");
  }

  static Future<Map<String, dynamic>> fetchUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    return {
      "email": email,
      "password": password,
    };
  }

//   static Future<void> saveToken(String token) async {
//     SharedPreferences instance = await SharedPreferences.getInstance();
//     await instance.setString("token", token);
//     log("Token saved");
//   }

//   static Future<String?> fetchToken() async {
//     SharedPreferences instance = await SharedPreferences.getInstance();
//     return instance.getString("token");
//   }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }
}
