import 'package:dio/dio.dart';
import 'package:teste_create_flutter/core/services/http_service.dart';
import 'package:teste_create_flutter/domain/repositories/user_service.dart';

class UserServiceRemote implements UserService {
  final Dio _dio = HttpService().dio;

  @override
  Future<Response> getUserById() async {
    return _dio.get('/user');
  }

  @override
  Future<Response> getUsersExcludeCurrentUser() async {
    return _dio.get('/users/exclude-current');
  }

  @override
  Future<Response> updateUserProfile(Map<String, dynamic> data) async {
    return _dio.patch('/user', data: data);
  }

  @override
  Future<Response> deleteUserAccount() async {
    return _dio.delete('/user');
  }
}
