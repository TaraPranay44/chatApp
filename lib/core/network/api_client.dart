// import 'dart:async';
// import 'dart:io';
// import 'package:chatapp/core/constants/url_constants.dart';
// import 'package:chatapp/core/error/exception_handler.dart';
// import 'package:chatapp/core/error/exception_severity.dart';
// import 'package:chatapp/core/error/exceptions.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// class ApiClient {
//   final Dio _dio;

//   // Constructor that creates and initializes Dio
//   ApiClient() : _dio = Dio() {
//     _initializeDio();
//   }

//   // Initialize Dio with configuration
//   void _initializeDio() {
//     _dio.options.baseUrl = ApiEndpoints.apiBaseUrl;
//     _dio.options.connectTimeout = ApiEndpoints.connectTimeout;
//     _dio.options.receiveTimeout = ApiEndpoints.receiveTimeout;
//     _dio.options.sendTimeout = ApiEndpoints.sendTimeout;
//     _dio.options.headers = Map.from(ApiEndpoints.defaultHeaders);

//     // Add interceptors
//     _addInterceptors();
//   }

//   // Add interceptors
//   void _addInterceptors() {
//     // Request interceptor
//     _dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) {
//         if (kDebugMode) {
//           print('REQUEST: ${options.method} ${options.path}');
//           print('Headers: ${options.headers}');
//           if (options.data != null) print('Data: ${options.data}');
//         }
//         handler.next(options);
//       },
//       onResponse: (response, handler) {
//         if (kDebugMode) {
//           print(
//               'RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
//         }
//         handler.next(response);
//       },
//       onError: (error, handler) {
//         if (kDebugMode) {
//           print(
//               'ERROR: ${error.response?.statusCode} ${error.requestOptions.path}');
//           print('Message: ${error.message}');
//         }
//         handler.next(error);
//       },
//     ));

//     // Token refresh interceptor
//     _dio.interceptors.add(InterceptorsWrapper(
//       onError: (error, handler) async {
//         if (error.response?.statusCode == 401) {
//           // Handle token refresh logic here
//           await _handleTokenRefresh();
//         }
//         handler.next(error);
//       },
//     ));

//     // Add logging interceptor only in debug mode
//     if (kDebugMode) {
//       _dio.interceptors.add(LogInterceptor(
//         request: true,
//         requestHeader: false, // Reduced logging to avoid clutter
//         requestBody: true,
//         responseHeader: false,
//         responseBody: true,
//         error: true,
//         logPrint: (object) => print(object),
//       ));
//     }
//   }

//   // Handle token refresh
//   Future<void> _handleTokenRefresh() async {
//     // Implement token refresh logic here
//     // This is a placeholder - implement based on your auth system
//     if (kDebugMode) {
//       print('Token refresh needed');
//     }
//   }

//   // GET request
//   Future<T> get<T>(
//     String endpoint, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.get<T>(
//         endpoint,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }

// // POST request with better error handling
//   Future<T> post<T>(
//     String endpoint, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     final response = await _dio.post(
//       endpoint,
//       data: data,
//       queryParameters: queryParameters,
//       options: options,
//       cancelToken: cancelToken,
//     );

//     // Additional validation for successful responses
//     if (response.statusCode != null &&
//         response.statusCode! >= 200 &&
//         response.statusCode! < 300) {
//       return response.data as T;
//     } else {
//       // This shouldn't happen, but handle it just in case
//       throw DioException(
//         requestOptions: response.requestOptions,
//         response: response,
//         type: DioExceptionType.badResponse,
//         message: 'Unexpected status code: ${response.statusCode}',
//       );
//     }
//   }

//   // PUT request
//   Future<T> put<T>(
//     String endpoint, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.put<T>(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }

//   // PATCH request
//   Future<T> patch<T>(
//     String endpoint, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.patch<T>(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }

//   // DELETE request
//   Future<T> delete<T>(
//     String endpoint, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.delete<T>(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }

//   // Upload file
//   Future<T> uploadFile<T>(
//     String endpoint, {
//     required String filePath,
//     required String fileKey,
//     Map<String, dynamic>? additionalData,
//     ProgressCallback? onSendProgress,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final formData = FormData();

//       // Add file
//       formData.files.add(MapEntry(
//         fileKey,
//         await MultipartFile.fromFile(filePath),
//       ));

//       // Add additional data
//       if (additionalData != null) {
//         additionalData.forEach((key, value) {
//           formData.fields.add(MapEntry(key, value.toString()));
//         });
//       }

//       final response = await _dio.post<T>(
//         endpoint,
//         data: formData,
//         onSendProgress: onSendProgress,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }

//   // Download file
//   Future<void> downloadFile(
//     String endpoint,
//     String savePath, {
//     ProgressCallback? onReceiveProgress,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       await _dio.download(
//         endpoint,
//         savePath,
//         onReceiveProgress: onReceiveProgress,
//         cancelToken: cancelToken,
//       );
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }

//   // Handle Dio errors with improved error handling
// // Handle Dio errors with improved error handling
//   Exception _handleError(DioException e) {
//     if (kDebugMode) {
//       print('DioException: ${e.type}, Message: ${e.message}');
//       print('Response: ${e.response?.data}');
//       print('Status Code: ${e.response?.statusCode}');
//       print('Request Options: ${e.requestOptions.uri}');
//     }

//     // CRITICAL: Check if response exists but exception occurred
//     if (e.response != null) {
//       final statusCode = e.response!.statusCode;
//       final responseData = e.response!.data;

//       // Handle success responses (2xx) that Dio is treating as errors
//       if (statusCode != null && statusCode >= 200 && statusCode < 300) {
//         if (kDebugMode) {
//           print('SUCCESS: Got $statusCode response but Dio treated as error');
//           print('Response data: $responseData');
//         }

//         // Don't throw an exception for success responses
//         // Instead, you should handle this in your API service layer
//         // For now, return a special exception that indicates success
//         return SuccessfulResponseException(
//           message: 'Request completed successfully with status $statusCode',
//           statusCode: statusCode,
//           responseData: responseData,
//         );
//       }
//     }

//     // Handle different Dio exception types
//     switch (e.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         return TimeoutException(
//           message: 'Request timeout. Please check your internet connection.',
//         );

//       case DioExceptionType.badResponse:
//         return _handleResponseError(e);

//       case DioExceptionType.cancel:
//         return RequestCancelledException(
//           message: 'Request was cancelled',
//         );

//       case DioExceptionType.connectionError:
//         if (e.error is SocketException) {
//           return NetworkException(
//             message: 'No internet connection. Please check your network.',
//           );
//         }
//         return NetworkException(
//           message: 'Connection error occurred',
//         );

//       case DioExceptionType.unknown:
//         // IMPORTANT: Handle unknown errors more carefully
//         if (e.response != null) {
//           final statusCode = e.response!.statusCode;
//           final responseData = e.response!.data;

//           if (kDebugMode) {
//             print('Unknown error with response:');
//             print('Status: $statusCode');
//             print('Data: $responseData');
//           }

//           // Check if it's actually a success response
//           if (statusCode != null && statusCode >= 200 && statusCode < 300) {
//             return SuccessfulResponseException(
//               message: 'Request completed successfully with status $statusCode',
//               statusCode: statusCode,
//               responseData: responseData,
//             );
//           }

//           // Handle actual error responses
//           return ExceptionHandler.fromHttpStatusCode(
//             statusCode ?? 500,
//             message: 'Response parsing error: ${e.message}',
//             responseBody: responseData?.toString(),
//           );
//         }

//         // Handle socket exceptions in unknown errors
//         if (e.error is SocketException) {
//           return NetworkException(
//             message: 'No internet connection',
//           );
//         }

//         return ServerException(
//           message: 'An unknown error occurred: ${e.message ?? 'Unknown error'}',
//         );

//       default:
//         return ServerException(
//           message: 'An unexpected error occurred',
//         );
//     }
//   }

//   // Handle response errors
//   // Exception _handleResponseError(DioException e) {
//   //   final statusCode = e.response?.statusCode;
//   //   final responseData = e.response?.data;

//   //   // Try to extract error message from response
//   //   String errorMessage = 'An error occurred';
//   //   if (responseData is Map<String, dynamic>) {
//   //     errorMessage = responseData['message'] ??
//   //         responseData['error'] ??
//   //         responseData['detail'] ??
//   //         errorMessage;
//   //   }

//   //   switch (statusCode) {
//   //     case 400:
//   //       return BadRequestException(message: errorMessage);
//   //     case 401:
//   //       return UnauthorizedException(message: errorMessage);
//   //     case 403:
//   //       return ForbiddenException(message: errorMessage);
//   //     case 404:
//   //       return NotFoundException(message: errorMessage);
//   //     case 422:
//   //       return ValidationException(message: errorMessage);
//   //     case 429:
//   //       return RateLimitException(message: errorMessage);
//   //     case 500:
//   //     case 501:
//   //     case 502:
//   //     case 503:
//   //     case 504:
//   //       return ServerException(message: errorMessage);
//   //     default:
//   //       return ServerException(message: errorMessage);
//   //   }
//   // }

//   Exception _handleResponseError(DioException e) {
//     final statusCode = e.response?.statusCode;
//     final responseData = e.response?.data;

//     // Double-check for success responses even in badResponse case
//     if (statusCode != null && statusCode >= 200 && statusCode < 300) {
//       return SuccessfulResponseException(
//         message: 'Request completed successfully with status $statusCode',
//         statusCode: statusCode,
//         responseData: responseData,
//       );
//     }

//     // Use the ExceptionHandler for proper error mapping
//     return ExceptionHandler.fromHttpStatusCode(
//       statusCode ?? 500,
//       message: e.message,
//       responseBody: responseData?.toString(),
//     );
//   }

//   // Token management
//   void setToken(String token) {
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   void removeToken() {
//     _dio.options.headers.remove('Authorization');
//   }

//   // Update headers
//   void updateHeaders(Map<String, String> headers) {
//     _dio.options.headers.addAll(headers);
//   }

//   // Get current headers
//   Map<String, dynamic> get headers => _dio.options.headers;

//   // Update base URL (useful for switching environments)
//   void updateBaseUrl(String baseUrl) {
//     _dio.options.baseUrl = baseUrl;
//   }

//   // Get current base URL
//   String get baseUrl => _dio.options.baseUrl;

//   // Cancel all requests
//   // void cancelAllRequests() {
//   //   _dio.();
//   // }

//   // Create a cancel token
//   CancelToken createCancelToken() => CancelToken();

//   // Close dio instance
//   void close() {
//     _dio.close();
//   }
// }

// class SuccessfulResponseException extends AppException {
//   final int statusCode;
//   final dynamic responseData;

//   SuccessfulResponseException({
//     required String message,
//     required this.statusCode,
//     this.responseData,
//   }) : super(
//           message: message,
//           userMessage: 'Request completed successfully',
//           errorCode: statusCode,
//           severity: ExceptionSeverity.low,
//         );

//   @override
//   String toString() {
//     return 'SuccessfulResponseException: $message (Status: $statusCode)';
//   }
// }




import 'dart:async';
import 'dart:io';
import 'package:chatapp/core/constants/url_constants.dart';
import 'package:chatapp/core/error/exception_handler.dart';
import 'package:chatapp/core/error/exception_severity.dart';
import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  final Dio _dio;
  final SecureStorageService _secureStorageService;

  // Constructor that creates and initializes Dio
  ApiClient({required SecureStorageService secureStorageService}) 
      : _dio = Dio(),
        _secureStorageService = secureStorageService {
    _initializeDio();
  }

  // Initialize Dio with configuration
  void _initializeDio() {
    _dio.options.baseUrl = ApiEndpoints.apiBaseUrl;
    _dio.options.connectTimeout = ApiEndpoints.connectTimeout;
    _dio.options.receiveTimeout = ApiEndpoints.receiveTimeout;
    _dio.options.sendTimeout = ApiEndpoints.sendTimeout;
    _dio.options.headers = Map.from(ApiEndpoints.defaultHeaders);

    // Add interceptors
    _addInterceptors();
  }

  // Add interceptors
  void _addInterceptors() {
    // Token interceptor - automatically adds token to requests
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get token from secure storage and add to headers
        final token = await _secureStorageService.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        
        if (kDebugMode) {
          print('REQUEST: ${options.method} ${options.path}');
          print('Headers: ${options.headers}');
          if (options.data != null) print('Data: ${options.data}');
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print('RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
        }
        handler.next(response);
      },
      onError: (error, handler) {
        if (kDebugMode) {
          print('ERROR: ${error.response?.statusCode} ${error.requestOptions.path}');
          print('Message: ${error.message}');
        }
        handler.next(error);
      },
    ));

    // Token refresh interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Handle token refresh logic here
          final refreshed = await _handleTokenRefresh();
          if (refreshed) {
            // Retry the original request
            final clonedRequest = await _dio.request(
              error.requestOptions.path,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );
            return handler.resolve(clonedRequest);
          }
        }
        handler.next(error);
      },
    ));

    // Add logging interceptor only in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (object) => print(object),
      ));
    }
  }

  // Handle token refresh
  Future<bool> _handleTokenRefresh() async {
    try {
      // This is a placeholder - implement based on your auth system
      // You might have a refresh token endpoint
      if (kDebugMode) {
        print('Token refresh needed');
      }
      
      // Example implementation:
      // 1. Get refresh token from secure storage
      // 2. Call refresh endpoint
      // 3. Store new token
      // 4. Return true if successful
      
      return false; // Return true if refresh was successful
    } catch (e) {
      if (kDebugMode) {
        print('Token refresh failed: $e');
      }
      // Clear invalid token
      await _secureStorageService.deleteToken();
      return false;
    }
  }

  // GET request
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true, // Flag to indicate if auth is required
  }) async {
    try {
      final response = await _dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request with better error handling
  Future<T> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.post<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      // Additional validation for successful responses
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response.data as T;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<T> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.put<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PATCH request
  Future<T> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.patch<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<T> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.delete<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Upload file
  Future<T> uploadFile<T>(
    String endpoint, {
    required String filePath,
    required String fileKey,
    Map<String, dynamic>? additionalData,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    try {
      final formData = FormData();

      // Add file
      formData.files.add(MapEntry(
        fileKey,
        await MultipartFile.fromFile(filePath),
      ));

      // Add additional data
      if (additionalData != null) {
        additionalData.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      final response = await _dio.post<T>(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Download file
  Future<void> downloadFile(
    String endpoint,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requiresAuth = true,
  }) async {
    try {
      await _dio.download(
        endpoint,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Handle Dio errors with improved error handling
  Exception _handleError(DioException e) {
    if (kDebugMode) {
      print('DioException: ${e.type}, Message: ${e.message}');
      print('Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      print('Request Options: ${e.requestOptions.uri}');
    }

    // CRITICAL: Check if response exists but exception occurred
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final responseData = e.response!.data;

      // Handle success responses (2xx) that Dio is treating as errors
      if (statusCode != null && statusCode >= 200 && statusCode < 300) {
        if (kDebugMode) {
          print('SUCCESS: Got $statusCode response but Dio treated as error');
          print('Response data: $responseData');
        }

        return SuccessfulResponseException(
          message: 'Request completed successfully with status $statusCode',
          statusCode: statusCode,
          responseData: responseData,
        );
      }
    }

    // Handle different Dio exception types
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Request timeout. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        return _handleResponseError(e);

      case DioExceptionType.cancel:
        return RequestCancelledException(
          message: 'Request was cancelled',
        );

      case DioExceptionType.connectionError:
        if (e.error is SocketException) {
          return NetworkException(
            message: 'No internet connection. Please check your network.',
          );
        }
        return NetworkException(
          message: 'Connection error occurred',
        );

      case DioExceptionType.unknown:
        if (e.response != null) {
          final statusCode = e.response!.statusCode;
          final responseData = e.response!.data;

          if (kDebugMode) {
            print('Unknown error with response:');
            print('Status: $statusCode');
            print('Data: $responseData');
          }

          if (statusCode != null && statusCode >= 200 && statusCode < 300) {
            return SuccessfulResponseException(
              message: 'Request completed successfully with status $statusCode',
              statusCode: statusCode,
              responseData: responseData,
            );
          }

          return ExceptionHandler.fromHttpStatusCode(
            statusCode ?? 500,
            message: 'Response parsing error: ${e.message}',
            responseBody: responseData?.toString(),
          );
        }

        if (e.error is SocketException) {
          return NetworkException(
            message: 'No internet connection',
          );
        }

        return ServerException(
          message: 'An unknown error occurred: ${e.message ?? 'Unknown error'}',
        );

      default:
        return ServerException(
          message: 'An unexpected error occurred',
        );
    }
  }

  // Handle response errors
  Exception _handleResponseError(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    // Double-check for success responses even in badResponse case
    if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      return SuccessfulResponseException(
        message: 'Request completed successfully with status $statusCode',
        statusCode: statusCode,
        responseData: responseData,
      );
    }

    // Use the ExceptionHandler for proper error mapping
    return ExceptionHandler.fromHttpStatusCode(
      statusCode ?? 500,
      message: e.message,
      responseBody: responseData?.toString(),
    );
  }

  // Manual token management methods (for specific use cases)
  Future<void> setToken(String token) async {
    await _secureStorageService.storeToken(token);
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<void> removeToken() async {
    await _secureStorageService.deleteToken();
    _dio.options.headers.remove('Authorization');
  }

  Future<String?> getToken() async {
    return await _secureStorageService.getToken();
  }

  // Update headers
  void updateHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  // Get current headers
  Map<String, dynamic> get headers => _dio.options.headers;

  // Update base URL (useful for switching environments)
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  // Get current base URL
  String get baseUrl => _dio.options.baseUrl;

  // Create a cancel token
  CancelToken createCancelToken() => CancelToken();

  // Close dio instance
  void close() {
    _dio.close();
  }
}

class SuccessfulResponseException extends AppException {
  final int statusCode;
  final dynamic responseData;

  SuccessfulResponseException({
    required String message,
    required this.statusCode,
    this.responseData,
  }) : super(
          message: message,
          userMessage: 'Request completed successfully',
          errorCode: statusCode,
          severity: ExceptionSeverity.low,
        );

  @override
  String toString() {
    return 'SuccessfulResponseException: $message (Status: $statusCode)';
  }
}