class RegisterRequestModel { // Campos obrigatórios (final -> imutáveis)
  // Classe que representa um modelo de dados com a estrutura das requisições de registro que são enviadas à API
  
  final String name;
  final String email;
  final String password;

  // Construtor com parâmetros nomeados e obrigatórios 
  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password
  });

  // Usa Map p/ converter string p/ JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password
  };
}