import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jumper/core/api.dart';
import 'package:jumper/data/models/user/user_model.dart';

class UserRepository {
  final _api = Api();

  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String city,
  }) async {
    try {
      Response response = await _api.sendRequest.post(
        "/user/createAccount",
        data: jsonEncode(
          {
            "email": email,
            "password": password,
            "fullName": fullName, // Add full name to request data
            "phoneNumber": phoneNumber, // Add phone number to request data
            "address": address, // Add address to request data
            "city": city, // Add city to request data
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

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
