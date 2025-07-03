import 'package:cashflow/app/core/errors/api_exception.dart';
import 'package:cashflow/app/features/authentication/register/domain/entities/register_entity.dart';
import 'package:cashflow/app/features/authentication/register/domain/usecases/register_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'register_state.dart';

// Gerenciador de estado p/ registro (usa StateNotifier - nativo do Riverpod)
class RegisterNotifier extends StateNotifier<RegisterState> {

  /*
    Classe que: 
      - Coordena a interação entre UI e lógica de negócio
      - Atualiza o estado na tela (carregando, sucesso ou erro)
      - Trata erros e fornece feedback ao usuário (mudar - talvez)
  */

  final RegisterUseCase registerUseCase; // Caso de uso injetado

  RegisterNotifier({
    required this.registerUseCase
  }) : super(RegisterInitial()); // Atualiza estado p/ "carregando"
  
  // Método principal -> executa o registro
  Future<void> register({
  required String name,
  required String email,
  required String password }) 
    
  async {
    state = RegisterLoading();
          
    // Cria a entidade de domínio com dados tratados
    try {
      final entity = RegisterEntity(
        name: name.trim(),
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );
      
      // Chama o caso de uso para registrar o usuário
      final response = await registerUseCase(entity);

      print('✅ Registro bem-sucedido: ${response.token}');
      
      // Atualiza estado para "sucesso" com mensagem personalizada
      state = RegisterSuccess('Bem-vindo, ${response.name}!');
    } 
    
    on ApiException catch (e) { // Tratamento p/ erro específico da API
      print('❌ Erro na API: ${e.message}');
      state = RegisterError(e.message);
    } 
    
    catch (e, stackTrace) { // Tratamento p/ erro desconhecido com mensagem genérica
      print('❌ Erro inesperado: $e\n$stackTrace');
      state = RegisterError('Falha no registro. Tente novamente.');
    }
  }
}