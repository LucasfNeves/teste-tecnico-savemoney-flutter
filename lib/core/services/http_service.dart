import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teste_create_flutter/domain/models/token_storage.dart';

import '../config/app_config.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  HttpService._internal();

  late Dio dio;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void initialize() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ));

    dio.interceptors.add(AuthInterceptor());
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = TokenStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _redirectToLogin();
    }
    handler.next(err);
  }

  void _redirectToLogin() {
    HttpService.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
      (route) => false,
    );
  }
}
