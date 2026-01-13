import 'package:dio/dio.dart';

abstract class AuthService {
  Future<Response> login(String email, String password);
}
