// Importing required packages
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Constants for base URL and default headers
const String BASE_URL = "http://192.168.1.70:5000/api";
const Map<String, dynamic> DEFAULT_HEADERS = {
  'Content-Type': 'application/json'
};

// Class responsible for making API requests
class Api {
  final Dio _dio = Dio();

  // Constructor
  Api() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADERS;
    _dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  // Getter for Dio instance
  Dio get sendRequest => _dio;
}

// Class representing the response from API requests
class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  // Factory method to create ApiResponse object from Dio Response
  factory ApiResponse.fromResponse(Response response) {
    final data = response.data
        as Map<String, dynamic>; // Extracting data from Dio Response

    // Creating ApiResponse object
    return ApiResponse(
        success: data["success"], // Setting success status from response data
        data: data["data"], // Setting data from response data
        message: data["message"] ??
            "Unexpected error"); // Setting message from response data or default message
  }
}
