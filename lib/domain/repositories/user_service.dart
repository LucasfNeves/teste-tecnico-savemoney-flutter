import 'package:dio/dio.dart';

abstract class UserService {
  Future<Response> getUserById();
}
