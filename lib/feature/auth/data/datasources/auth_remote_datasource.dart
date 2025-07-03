import 'package:chatapp/core/constants/url_constants.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/login_request.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginRequest request);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  
  AuthRemoteDataSourceImpl(this.dio);
  
  @override
  Future<UserModel> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );
      
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['user']);
      } else {
        throw ServerException(
          message: 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    }
  }
  
  @override
  Future<void> logout() async {
    try {
      await dio.post(ApiEndpoints.logout);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Logout failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
