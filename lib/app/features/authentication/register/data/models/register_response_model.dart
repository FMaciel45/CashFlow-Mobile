class RegisterResponseModel { 
  // Classe que representa um modelo de dados com a estrutura das respostas da API às requisições de registro enviadas

  final String? id; // ? -> pode ser nulo
  final String name;
  final String? email;
  final String? token;

  // Construtor principal
  RegisterResponseModel({
    this.id,
    required this.name,
    this.email,
    this.token,
  });

  // Factory constructor p/ converter JSON em RegisterResponseModel
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }
}