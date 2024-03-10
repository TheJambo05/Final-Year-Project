// Importing necessary packages and files

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jumper/core/api.dart';
import '../models/user/product/product_model.dart';

// Class responsible for interacting with the user-related APIs
class ProductRepository {
  final _api = Api();

/////fetchAllProductByCategory
  Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
    try {
      Response response =
          await _api.sendRequest.get("/product/category/$categoryId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

///// fetchAllProduct///////////////
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get("/product");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

/////addProduct
  Future<ProductModel> addProduct(
      {required String title,
      required String description,
      required String price}) async {
    try {
      Response response = await _api.sendRequest.post(
        "/product",
        data: jsonEncode(
          {"title": title, "description": description, "price": price},
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // Handling unsuccessful response
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return ProductModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
