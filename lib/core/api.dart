// Importing required packages
import 'package:dio/dio.dart'; // Package for making HTTP requests
import 'package:pretty_dio_logger/pretty_dio_logger.dart'; // Package for logging HTTP requests in a pretty format

// Constants for base URL and default headers
const String BASE_URL =
    "http://192.168.1.70:5000/api"; // Base URL for API endpoints
const Map<String, dynamic> DEFAULT_HEADERS = {
  'Content-Type': 'application/json' // Default headers for HTTP requests
};

// Class responsible for making API requests
class Api {
  final Dio _dio = Dio(); // Dio instance for making HTTP requests

  // Constructor
  Api() {
    _dio.options.baseUrl = BASE_URL; // Setting base URL for Dio instance
    _dio.options.headers =
        DEFAULT_HEADERS; // Setting default headers for Dio instance
    _dio.interceptors.add(PrettyDioLogger(
        // Adding interceptor for logging requests and responses
        requestBody: true, // Log request body
        requestHeader: true, // Log request headers
        responseBody: true, // Log response body
        responseHeader: true)); // Log response headers
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
