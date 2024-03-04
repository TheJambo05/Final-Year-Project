// Importing necessary packages and files

import 'package:dio/dio.dart';
import 'package:jumper/core/api.dart';
import 'package:jumper/data/models/user/category/category_model.dart';

// Class responsible for interacting with the user-related APIs
class CategoryRepository {
  final _api = Api();

  // Method to create a user account
  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      // Sending POST request to create an account
      Response response = await _api.sendRequest.get("/category");

      // Parsing response into ApiResponse object
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // Handling unsuccessful response
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
