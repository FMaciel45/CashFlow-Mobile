class RegisterEntity { // Classe que representa os dados essenciais para o registro de um usuário

  // Campos obrigatórios e imutáveis (final)
  final String name;
  final String email;
  final String password;

  RegisterEntity({
    required this.name,
    required this.email,
    required this.password,
  });
}