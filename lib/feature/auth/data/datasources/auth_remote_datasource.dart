import 'dart:developer';

import 'package:chatapp/core/error/exception_handler.dart';
import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/network/api_client.dart';
import 'package:chatapp/feature/auth/data/models/send_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/verify_otp_request.dart';
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
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate a successful response
      log("OTP sent successfully to ${request.email.isNotEmpty ? request.email : request.phone}");

      return true;
    } on AppException catch (e) {
      ExceptionHandler().handleException(e);
      return false;
    }
  }

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
