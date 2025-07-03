import '../entities/register_entity.dart';
import '../../data/models/register_response_model.dart';

/*
  - Interface abstrata ("contrato") para o repositório de registro
  - Segue o princípio de inversão de dependências (SOLID)
    - Descreve o que deve ser feito, sem se preocupar como será implementado
  - Vantagens: isola a regra de negócio de aspectos externos (req. HTTP, BD, ...) e + fácil de testar
*/

abstract class RegisterRepository {
  // Método que toda implementação concreta deve seguir
  Future<RegisterResponseModel> register(RegisterEntity entity);
}