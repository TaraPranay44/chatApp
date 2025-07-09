import 'dart:developer';

import 'package:chatapp/core/constants/url_constants.dart';
import 'package:chatapp/core/error/exception_handler.dart';
import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/network/api_client.dart';
import 'package:chatapp/feature/auth/data/models/request_models/send_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/request_models/verify_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/response_models/send_otp_response.dart';
import 'package:chatapp/feature/auth/data/models/response_models/verify_otp_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart' as tuple;

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

  Future<tuple.Tuple2<String, bool>> verifyOtp(
      {required VerifyOtpRequest request});
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
      rethrow; // 🔁 Rethrow so repository can catch and return Left(Failure)
    } on Exception catch (e) {
      log("Unexpected error in sendOtp: $e");
      throw ServerException(message: e.toString()); // 🔁 Throw expected type
    }
  }

  @override
  Future<tuple.Tuple2<String, bool>> verifyOtp(
      {required VerifyOtpRequest request}) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.verifyOtp,
        data: verifyOtpRequestToJson(request),
      );

      final verifyOtpResponse = VerifyOtpResponse.fromJson(response);

      if (verifyOtpResponse.accessToken != null &&
          verifyOtpResponse.accessToken!.isNotEmpty) {
        log("OTP verified successfully for ${request.email!.isNotEmpty ? request.email : request.phone}");
        return tuple.Tuple2(verifyOtpResponse.accessToken ?? '', true);
      } else {
        return const tuple.Tuple2('', false);
      }
    } on AppException catch (e) {
      ExceptionHandler().handleException(e);
      rethrow; // 🔁 Rethrow so repository can catch and return Left(Failure)
    } on Exception catch (e) {
      log("Unexpected error in verifyotp: $e");
      throw ServerException(message: e.toString()); // 🔁 Throw expected type
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
