import 'package:dio/dio.dart';
import 'package:teste_create_flutter/core/services/http_service.dart';
import 'package:teste_create_flutter/domain/repositories/user_service.dart';

class UserServiceRemote implements UserService {
  final Dio _dio = HttpService().dio;

  @override
  Future<Response> getUserById() async {
    return _dio.get('/user');
  }
}
