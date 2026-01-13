import 'package:dio/dio.dart';
import 'package:teste_create_flutter/domain/repositories/auth_service.dart';
import 'package:teste_create_flutter/core/services/http_service.dart';

class AuthServiceRemote implements AuthService {
  final Dio _dio = HttpService().dio;

  @override
  Future<Response> login(String email, String password) async {
    return await _dio.post('/auth/sign-in', data: {
      'email': email,
      'password': password,
    });
  }
}
