import 'dart:developer';

import 'package:chatapp/core/constants/url_constants.dart';
import 'package:chatapp/core/error/exception_handler.dart';
import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/network/api_client.dart';
import 'package:chatapp/feature/auth/data/models/request_models/send_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/request_models/verify_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/response_models/send_otp_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRemoteDataSource {
  /// Login a user with email and password
  // Future<UserModel> login({required LoginRequest request});

  /// Register a new user
  // Future<UserModel> register({
  //   required String name,
  //   required String email,
  //   required String password,
  // });

  Future<bool> sendOtp({required SendOtpRequest request});

  Future<bool> verifyOtp({required VerifyOtpRequest request});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<bool> sendOtp({required SendOtpRequest request}) async {
    try {
      // Make POST request to send OTP endpoint
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.sendOtp,
        data: sendOtpRequestToJson(request),
      );

      // Convert the Map to SendOtpResponse
      final sendOtpResponse = SendOtpResponse.fromJson(response);

      // Check if response is successful
      if (sendOtpResponse.message != null &&
          sendOtpResponse.message!.isNotEmpty) {
        if (sendOtpResponse.message == "OTP sent successfully") {
          log("OTP sent successfully to ${request.email.isNotEmpty ? request.email : request.phone}");
          return true;
        } else {
          return false;
        }
      }

      return false;
    } on AppException catch (e) {
      ExceptionHandler().handleException(e);
      return false;
    } catch (e) {
      log("Unexpected error in sendOtp: $e");
      return false;
    }
  }

//   @override
// Future<bool> sendOtp({required SendOtpRequest request}) async {
//   try {
//     // Make POST request to send OTP endpoint
//     final response = await _apiClient.post<Map<String, dynamic>>(
//       ApiEndpoints.sendOtp,
//       data: request.toJson(),
//     );

//     // Check if response is successful
//     if (response != null) {
//       if (kDebugMode) {
//         print("OTP sent successfully to ${request.email.isNotEmpty ? request.email : request.phone}");
//         print("Response: $response");
//       }
//       return true;
//     }

//     return false;
//   } on AppException catch (e) {
//     if (kDebugMode) {
//       print("AppException in sendOtp: ${e.message}");
//     }

//     // Check if it's actually a success but treated as error
//     if (e is UnknownException && e.message.contains('Success response')) {
//       return true;
//     }

//     ExceptionHandler().handleException(e);
//     return false;
//   } catch (e) {
//     if (kDebugMode) {
//       print("Unexpected error in sendOtp: $e");
//     }
//     return false;
//   }
// }

  @override
  Future<bool> verifyOtp({required VerifyOtpRequest request}) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate a successful response
      log("OTP verified successfully for ${request.email!.isNotEmpty ? request.email : request.phone}");

      return true;
    } on AppException catch (e) {
      ExceptionHandler().handleException(e);
      return false;
    }
  }
}

// Provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDataSourceImpl(apiClient);
});

// ApiClient provider
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
