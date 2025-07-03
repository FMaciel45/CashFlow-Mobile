import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cashflow/app/core/config/api_config.dart';

// Provider p/ criar e configurar uma instância do Dio
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl, // URL da API 
  ));
  
  // Configura interceptores p/ req/res
  dio.interceptors.add(LogInterceptor(
    request: true, // Loga detalhes da requisição 
    responseBody: true, // Loga o corpo da resposta
    error: true, // Loga erros detalhadamente
  ));
  
  return dio; // Retorna o Dio configurado 
});