import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/auth/data/models/send_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/verify_otp_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  /// Login a user with email and password
  // Future<Either<Failure, UserEntity>> login({
  //   required String emailOrPhone,
  //   required String otp,
  // });

  /// Register a new user
  // Future<Either<Failure, UserEntity>> register({
  //   required String name,
  //   required String email,
  //   required String password,
  // });

  /// Logout the current user
  Future<Either<Failure, void>> logout();

  // /// Check if a user is authenticated
  // Future<Either<Failure, bool>> isAuthenticated();

  // /// Get the current authenticated user
  // Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Send otp to mobile or email
  Future<Either<Failure, bool>> sendOtp({required SendOtpRequest request});
  Future<Either<Failure, bool>> verifyOtp({required VerifyOtpRequest request});
}
