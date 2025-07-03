/*
  Define os estados possíveis do fluxo de registro de usuários usando o padrão sealed class
    - sealed class -> todos os estados possíveis são conhecidos em tempo de compilação
*/

sealed class RegisterState {
  const RegisterState(); // Construtor constante p/ imutabilidade
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message; // Mensagem personalizada (ex.: "Bem-vindo, João!")
  const RegisterSuccess(this.message);
}

class RegisterError extends RegisterState {
  final String message; // Mensagem de erro (ex.: "E-mail já cadastrado")
  const RegisterError(this.message);
}