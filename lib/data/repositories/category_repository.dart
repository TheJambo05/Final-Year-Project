// Importing necessary packages and files

import 'package:dio/dio.dart';
import 'package:jumper/core/api.dart';
import 'package:jumper/data/models/user/category/category_model.dart';

class CategoryRepository {
  final _api = Api();

  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

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
