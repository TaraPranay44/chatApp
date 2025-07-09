import 'dart:developer';

import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/core/network/api_client.dart';
import 'package:chatapp/core/storage/secure_storage.dart';
import 'package:chatapp/feature/auth/data/datasources/auth_local_datasource.dart';
import 'package:chatapp/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chatapp/feature/auth/data/models/request_models/send_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/request_models/verify_otp_request.dart';
import 'package:chatapp/feature/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart' as tuple;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  // final SecureStorageService _secureStorageService;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    // required SecureStorageService secureStorageService,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;
  //  _secureStorageService = secureStorageService;


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
      tuple.Tuple2<String, bool> result =
          await _remoteDataSource.verifyOtp(request: request);
      _localDataSource.storeToken(result.item1);
      return Right(result.item2); // or result.$2 — both work
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

final localStorageServiceProvider = Provider<AuthLocalDataSource>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthLocalDataSourceImpl(secureStorage);
});

// final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
//   return SecureStorageService(storage);
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
    localDataSource: ref.watch(localStorageServiceProvider),
  );
});
