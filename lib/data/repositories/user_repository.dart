// Importing necessary packages and files
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jumper/core/api.dart';
import 'package:jumper/data/models/user/user/user_model.dart';

// Class responsible for interacting with the user-related APIs
class UserRepository {
  final _api = Api();

  // Method to create a user account
  Future<UserModel> createAccount(
      {required String email, required String password}) async {
    try {
      // Sending POST request to create an account
      Response response = await _api.sendRequest.post(
        "/user/createAccount",
        data: jsonEncode(
          {"email": email, "password": password},
        ),
      );

      // Parsing response into ApiResponse object
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // Handling unsuccessful response
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Converting raw data from response to UserModel object
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  // Method to sign in user
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      // Sending POST request to sign in
      Response response = await _api.sendRequest.post(
        "/user/signIn",
        data: jsonEncode(
          {"email": email, "password": password},
        ),
      );

      // Parsing response into ApiResponse object
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // Handling unsuccessful response
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Converting raw data from response to UserModel object
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
