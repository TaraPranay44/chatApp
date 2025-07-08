import 'dart:developer';

import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/core/network/api_client.dart';
import 'package:chatapp/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chatapp/feature/auth/data/models/request_models/send_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/request_models/verify_otp_request.dart';
import 'package:chatapp/feature/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  // final LocalStorageService _localStorageService;
  // final SecureStorageService _secureStorageService;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    // required LocalStorageService localStorageService,
    // required SecureStorageService secureStorageService,
  }) : _remoteDataSource = remoteDataSource;
  //  _localStorageService = localStorageService,
  //  _secureStorageService = secureStorageService;

  // @override
  // Future<Either<Failure, UserEntity>> login({
  //   required String emailOrPhone,
  //   required String otp,
  // }) async {
  //   try {
  //     LoginRequest loginRequest =
  //         LoginRequest(emailOrPhone: emailOrPhone, otp: otp);
  //     final response = await _remoteDataSource.login(request: loginRequest);

  //     // Save user data locally
  //     // await _localStorageService.setObject(AppConstants.userDataKey, response.toJson());

  //     // // Save auth token securely
  //     // await _secureStorageService.write(
  //     //   key: AppConstants.tokenKey,
  //     //   value: response.id, // assuming token is stored in id for demo
  //     // );

  //     return Right(response.toEntity());
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(message: e.message));
  //   } on NetworkException {
  //     return const Left(NetworkFailure());
  //   } on UnauthorizedException catch (e) {
  //     return Left(AuthFailure(message: e.message));
  //   } on Exception {
  //     return const Left(ServerFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, UserEntity>> register({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await _remoteDataSource.register(
  //       name: name,
  //       email: email,
  //       password: password,
  //     );

  //     // Save user data locally
  //     // await _localStorageService.setObject(AppConstants.userDataKey, response.toJson());

  //     // // Save auth token securely
  //     // await _secureStorageService.write(
  //     //   key: AppConstants.tokenKey,
  //     //   value: response.id, // assuming token is stored in id for demo
  //     // );

  //     return Right(response.toEntity());
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(message: e.message));
  //   } on NetworkException {
  //     return const Left(NetworkFailure());
  //   } on BadRequestException catch (e) {
  //     return Left(ValidationFailure(message: e.message));
  //   } on Exception {
  //     return const Left(ServerFailure());
  //   }
  // }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Remove user data from local storage
      // await _localStorageService.remove(AppConstants.userDataKey);

      // // Remove auth token from secure storage
      // await _secureStorageService.delete(key: AppConstants.tokenKey);

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on Exception {
      return const Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, bool>> isAuthenticated() async {
  //   try {
  //     // final token = await _secureStorageService.read(key: AppConstants.tokenKey);
  //     // return Right(token != null && token.isNotEmpty);
  //     return const Right(true);
  //   } on CacheException catch (e) {
  //     return Left(CacheFailure(message: e.message));
  //   } on Exception {
  //     return const Left(ServerFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, UserEntity>> getCurrentUser() async {
  //   try {
  //     // final userData = _localStorageService.getObject(AppConstants.userDataKey);

  //     // if (userData == null) {
  //     //   return const Left(AuthFailure(message: 'User not found'));
  //     // }

  //     // final user = UserModel.fromJson(userData as Map<String, dynamic>);
  //     // return Right(user.toEntity());
  //     return  Right(UserEntity.empty());
  //   } on CacheException catch (e) {
  //     return Left(CacheFailure(message: e.message));
  //   } on Exception {
  //     return const Left(ServerFailure());
  //   }
  // }

  @override
  Future<Either<Failure, bool>> sendOtp(
      {required SendOtpRequest request}) async {
    try {
      final otp = await _remoteDataSource.sendOtp(request: request);
      return Right(otp);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on BadRequestException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on Exception catch (e) {
      log("Unexpected error in sendOtp: $e");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(
      {required VerifyOtpRequest request}) async {
    try {
      final otp = await _remoteDataSource.verifyOtp(request: request);
      return Right(otp);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on BadRequestException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on Exception catch (e) {
      log("Unexpected error in sendOtp: $e");
      return const Left(ServerFailure());
    }
  }
}

// Dependencies
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

// // Using sharedPreferencesProvider from main.dart

// final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
//   final prefs = ref.watch(sharedPreferencesProvider);
//   return LocalStorageService(prefs);
// });

// final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
//   return SecureStorageService.create();
// });

// Remote data source provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDataSourceImpl(apiClient);
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    // localStorageService: ref.watch(localStorageServiceProvider),
    // secureStorageService: ref.watch(secureStorageServiceProvider),
  );
});
