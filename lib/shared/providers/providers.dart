// // shared/providers/providers.dart
// import 'package:chatapp/feature/auth/data/datasources/auth_local_datasource.dart';
// import 'package:chatapp/feature/auth/data/datasources/auth_remote_datasource.dart';
// import 'package:chatapp/feature/auth/data/repositories/auth_repository_impl.dart';
// import 'package:chatapp/feature/auth/domain/repositories/auth_repository.dart';
// import 'package:chatapp/feature/auth/domain/usecases/login_usecase.dart';
// import 'package:chatapp/feature/auth/domain/usecases/logout_usecase.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dio/dio.dart';
// import '../../core/database/app_database.dart';
// import '../../core/network/network_info.dart';
// import '../../core/storage/secure_storage.dart';

// // Database
// final databaseProvider = Provider<AppDatabase>((ref) {
//   throw UnimplementedError('Database provider must be overridden');
// });

// // Data Sources
// final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
//   return AuthRemoteDataSourceImpl(ref.read(dioProvider));
// });

// final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
//   return AuthLocalDataSourceImpl(ref.read(secureStorageProvider));
// });

// // Repositories
// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   return AuthRepositoryImpl(
//     remoteDataSource: ref.read(authRemoteDataSourceProvider),
//     localDataSource: ref.read(authLocalDataSourceProvider),
//     networkInfo: ref.read(networkInfoProvider),
//   );
// });

// // Use Cases
// final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
//   return LoginUseCase(ref.read(authRepositoryProvider));
// });

// final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
//   return LogoutUseCase(ref.read(authRepositoryProvider));
// });
