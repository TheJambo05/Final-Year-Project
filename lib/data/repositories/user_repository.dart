import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jumper/core/api.dart';
import 'package:jumper/data/models/user/user_model.dart';

class UserRepository {
  final Api _api = Api();

  /// Creates a new user account with the provided details.
  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String city,
  }) async {
    try {
      // Sending a POST request to create a new user account
      final response = await _api.sendRequest.post(
        "/user/createAccount",
        data: jsonEncode(
          {
            "email": email,
            "password": password,
            "fullName": fullName,
            "phoneNumber": phoneNumber,
            "address": address,
            "city": city,
          },
        ),
      );

      // Parsing the API response into ApiResponse object
      final apiResponse = ApiResponse.fromResponse(response);

      // Handling unsuccessful response
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Returning the UserModel object created from the API response data
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      // Rethrowing the exception to maintain original stack trace
      rethrow;
    }
  }

  /// Authenticates the user with the provided email and password.
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sending a POST request to sign in the user
      final response = await _api.sendRequest.post(
        "/user/signIn",
        data: jsonEncode(
          {"email": email, "password": password},
        ),
      );

      // Parsing the API response into ApiResponse object
      final apiResponse = ApiResponse.fromResponse(response);

      // Handling unsuccessful response
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Returning the UserModel object created from the API response data
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      // Rethrowing the exception to maintain original stack trace
      rethrow;
    }
  }

  /// Updates user information with the provided UserModel.
  Future<UserModel> updateUser(UserModel userModel) async {
    try {
      // Sending a PUT request to update user information
      final response = await _api.sendRequest.put(
        "/user/${userModel.sId}",
        data: jsonEncode(userModel.toJson()),
      );

      // Parsing the API response into ApiResponse object
      final apiResponse = ApiResponse.fromResponse(response);

      // Handling unsuccessful response
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // Returning the UserModel object created from the API response data
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      // Rethrowing the exception to maintain original stack trace
      rethrow;
    }
  }
}
