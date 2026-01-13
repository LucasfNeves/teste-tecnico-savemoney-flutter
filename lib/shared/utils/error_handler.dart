import 'package:dio/dio.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException && error.response != null) {
      return error.response!.data['message'] ??
          error.response!.data['error'] ??
          'Erro: ${error.response!.statusCode}';
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
