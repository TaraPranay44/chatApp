// features/auth/data/datasources/auth_local_datasource.dart
import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<void> storeToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService secureStorage;
  
  AuthLocalDataSourceImpl(this.secureStorage);
  
  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await secureStorage.storeUserData(json.encode(user.toJson()));
    } catch (e) {
      throw CacheException(message: 'Failed to cache user data');
    }
  }
  
  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userData = await secureStorage.getUserData();
      if (userData != null) {
        return UserModel.fromJson(json.decode(userData));
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to get cached user data');
    }
  }
  
  @override
  Future<void> clearCache() async {
    try {
      await secureStorage.clearAll();
    } catch (e) {
      throw CacheException(message: 'Failed to clear cache');
    }
  }
  
  @override
  Future<void> storeToken(String token) async {
    try {
      await secureStorage.storeToken(token);
    } catch (e) {
      throw CacheException(message: 'Failed to store token');
    }
  }
  
  @override
  Future<String?> getToken() async {
    try {
      return await secureStorage.getToken();
    } catch (e) {
      throw CacheException(message: 'Failed to get token');
    }
  }
  
  @override
  Future<void> deleteToken() async {
    try {
      await secureStorage.deleteToken();
    } catch (e) {
      throw CacheException(message: 'Failed to delete token');
    }
  }
}
