import 'package:dio/dio.dart';

// Dio -> pacote para realizar requisições a APIs RESTful (GET, POST, PUT, ...)

class ApiException implements Exception { // Classe p/ erros customizados
  final String? code; // ? -> torna o atributo opcional
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({ // Construtor
    this.code,
    required this.message,
    this.statusCode,
    this.data,
  });

  // Construtor factory p/ converter erros do Dio em ApiException
  factory ApiException.fromDioException(DioException e) {
    
    // Padronização -> + legibilidade e fácil manutenção
    final errorResponse = e.response; 
    final errorMessage = e.message;
    final responseData = errorResponse?.data;
    final errorStatusCode = errorResponse?.statusCode;

    try {
      return ApiException(
        code: responseData['code']?.toString(), // Extrai o corpo da mensagem de erro
        message: responseData['message']?.toString() ?? errorMessage ?? 'Unknown error occurred', // Fallback p/ mensagem de erro do Dio (se não capturar a mensagem de erro, lança uma mensagem genérica)
        statusCode: errorStatusCode,
        data: responseData // Corpo da mensagem de erro
      );

    } catch (_) { // Caso a conversão falhe 
      return ApiException(
        message: errorMessage ?? 'Unknown error occurred',
        statusCode: errorStatusCode,
      );
    }
  }

  @override
  String toString() { // P/ exibir o método "toString" de maneira mais "amigável"
    if (code != null) return '[$code] $message';
    if (statusCode != null) return '[$statusCode] $message';
    return message;
  }
}