import 'package:cashflow/app/core/errors/api_exception.dart';
import '../datasources/register_remote_data_source.dart';
import '../../domain/repositories/register_repository.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../../domain/entities/register_entity.dart';

// Implementação concreta do repositório de registro
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;
  
  // Construtor: recebe a fonte de dados remota via injeção de dependências
  RegisterRepositoryImpl({
    required this.remoteDataSource
  });

  @override
  Future<RegisterResponseModel> register(RegisterEntity user) async { // Converte a entidade de domínio (RegisterEntity) p/ o modelo de requisição (RegisterRequestModel)
    try {
      final request = RegisterRequestModel(
        name: user.name,
        email: user.email,
        password: user.password,
      );
      
      // Chama remoteDataSource p/ enviar a requisição à API
      return await remoteDataSource.register(request);
    } 
     
    on ApiException { // Repassa a ApiException p/ as camadas superiores -> erros específicos da API (ex.: 400 Bad Request) são repassados sem modificação
      rethrow; 
    } 
    
    catch (e) { // Erros inesperados (ex.: falha de conversão) são encapsulados em ApiException
      throw ApiException(message: 'Failed to register user: ${e.toString()}');
    }
  }
}