import 'package:dio/dio.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException && error.response != null) {
      final data = error.response!.data;

      if (data is Map<String, dynamic>) {
        return data['message'] ??
            data['error'] ??
            'Erro: ${error.response!.statusCode}';
      }

      if (data is String) {
        return data.isNotEmpty ? data : 'Erro: ${error.response!.statusCode}';
      }

      return 'Erro: ${error.response!.statusCode}';
    }

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Tempo limite de conexão excedido';
        case DioExceptionType.connectionError:
          return 'Erro de conexão com o servidor';
        case DioExceptionType.cancel:
          return 'Requisição cancelada';
        default:
          return 'Erro de rede';
      }
    }

    return error.toString().isNotEmpty ? error.toString() : 'Erro desconhecido';
  }
}
