import 'package:dio/dio.dart';
import 'package:teste_create_flutter/core/services/http_service.dart';
import 'package:teste_create_flutter/core/services/register/register_service.dart';

class RegisterServiceRemote implements RegisterService {
  final Dio _dio = HttpService().dio;

  @override
  Future<Response> register(
      String name, String email, String password, List<Map<String, dynamic>> phones) async {
    return _dio.post('/auth/sign-up', data: {
      'name': name,
      'email': email,
      'password': password,
      'telephones': phones,
    });
  }
}
