import '../repositories/register_repository.dart';
import '../entities/register_entity.dart';
import '../../data/models/register_response_model.dart';

// Caso de uso para registro de usuário
class RegisterUseCase {
  final RegisterRepository repository; // Dependência injetada

  RegisterUseCase({
    required this.repository
  });

  // Método principal: executa o registro
  Future<RegisterResponseModel> call(RegisterEntity entity) {
    return repository.register(entity); // "Delega" a operação para o repositório
  }
}