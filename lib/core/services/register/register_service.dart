import 'package:dio/dio.dart';

abstract class RegisterService {
  Future<Response> register(
      String name, String email, String password, List<Map<String, dynamic>> phones);
}
