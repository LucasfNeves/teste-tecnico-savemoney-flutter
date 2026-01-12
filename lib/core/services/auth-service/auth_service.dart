import 'package:dio/dio.dart';

abstract class AuthService {
  Future<Response> login(String email, String password);
  Future<Response> register(String email, String password);
  Future<void> logout();
}
