import 'package:dio/dio.dart';

abstract class UserService {
  Future<Response> getUserById();
  Future<Response> getUsersExcludeCurrentUser();
  Future<Response> updateUserProfile(Map<String, dynamic> data);
  Future<Response> deleteUserAccount();
}
