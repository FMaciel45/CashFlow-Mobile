import 'package:cashflow/app/core/config/api_config.dart';
import 'package:cashflow/app/core/errors/api_exception.dart';
import 'package:dio/dio.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

// Interface abstrata -> "contrato" para a fonte de dados
abstract class RegisterRemoteDataSource {
  Future<RegisterResponseModel> register(RegisterRequestModel request);
}

// Classe que implementa a camada de acesso aos dados p/ o registro (API)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final Dio dio; // Injeção de dependência do Dio

  RegisterRemoteDataSourceImpl({
    required this.dio
  });

  // Método p/ registrar
  @override
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {

    /*
      Future<RegisterResponseModel> -> Indica que é assíncrono e retorna um Future (promessa) e, quando resolvida, retorna um RegisterResponseModel

      (RegisterRequestModel request) -> Recebe um objeto de RegisterRequestModel como parâmetro, contendo os dados do usuário (nome, e-mail e senha) já validados

      async -> Marca o método como assíncrono e permite o uso do await p/ "esperar" as chamadas HTTP
    */

    try {
      print('🔵 JSON enviado: ${request.toJson()}'); // Log detalhado (debug)

      final response = await dio.post( // Requisição POST p/ API
        ApiConfig.registerEndpoint, // Endpoint centralizado em arquivo de configs
        data: request.toJson(), // Corpo da requisição convertido p/ JSON
        options: Options(
          validateStatus: (status) => status! < 500, // Considera como sucesso códigos < 500
        ),
      );

      // Tratamento p/ a resposta 
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Quando há sucesso, converte o JSON p/ RegisterResponseModel
        return RegisterResponseModel.fromJson(response.data);
      } 
      
      else { // Se a API retornar um status de erro (400-499)
        throw ApiException( // Exibição da mensagem de erro customizada
          code: response.data['code']?.toString(),
          message: response.data['message']?.toString() ?? 'Registration failed',
          statusCode: response.statusCode,
          data: response.data,
        );
      }
    } 
    
    on DioException catch (e) { // Captura erros do Dio (ex.: timeout ou conexão)
      throw ApiException.fromDioException(e);
    } 
    
    catch (e) { // Captura erros inesperados e envia mensagem de erro genérica
      throw ApiException(message: 'Unknown error occurred: ${e.toString()}');
    }
  }
}