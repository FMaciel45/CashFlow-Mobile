import 'package:flutter/material.dart';
import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:go_router/go_router.dart';

/* 
  Melhorias/ToDos:
  - Integrar c/ API (.NET) 
  - Separar responsabilidades
  - Refatorar o que puder 
  - Implementar light/dark theme
  - Melhorar validações
  - Implementar pacotes/libs recomendados
  - Implementar termos de uso - talvez 
  - Implementar navegação automáica após o cadastro
  - Animar botão de cadastro (loading - progress indicator)
*/

class CashFlowRegisterScreen extends StatefulWidget {
  const CashFlowRegisterScreen({super.key});

  @override
  State<CashFlowRegisterScreen> createState() => _CashFlowRegisterScreenState();
}

class _CashFlowRegisterScreenState extends State<CashFlowRegisterScreen> {
  // Chave global para validação e controle do formulário
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos do formulário
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Estados para controlar se as senhas estão visíveis ou ocultas
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Dispose -> limpeza de recursos (evita vazamentos de memória)
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Método principal de construção da interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CashFlowColors.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a seta de voltar (padrão)
        centerTitle: true,
        title: const Text(
          "CashFlow",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CashFlowColors.textWhiteColor,
          ),
        ),

        backgroundColor: CashFlowColors.primaryColor,
        elevation: 0, // Remove sombra do AppBar
      ),

      // Corpo da tela com SingleChildScrollView para rolagem
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( // Padding consistente com o design system
          horizontal: CashFlowSizes.mediumPadding,
          vertical: CashFlowSizes.largePadding,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Título
            Text(
              "Crie sua conta",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: CashFlowColors.textPrimaryColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.smallSpacing),

            // Subtítulo
            Text(
              "Preencha os campos para criar sua conta",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: CashFlowColors.textSecondaryColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.largeSpacing),

            // Formulário
            Form(
              key: _formKey, // Chave para controle do formulário
              child: Column(
                children: [

                  // Nome
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name, // Otimização de input (teclado)
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: const InputDecoration(
                      labelText: "Nome completo",
                      labelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.person, color: CashFlowColors.textSecondaryColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor, width: 2),
                      ),
                    ),

                    // Validações - melhorar depois
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite seu nome";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.normalSpacing),

                  // Campo de e-mail
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: const InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.mail, color: CashFlowColors.textSecondaryColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor, width: 2),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite seu e-mail";
                      }
                      if (!value.contains('@')) {
                        return "E-mail inválido";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.normalSpacing),

                  // Campo de senha
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: const TextStyle(color: CashFlowColors.textSecondaryColor),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: const Icon(Icons.password, color: CashFlowColors.textSecondaryColor),

                      suffixIcon: IconButton( // Botão para alternar visibilidade da senha
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          color: CashFlowColors.textSecondaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),

                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),

                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),

                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor, width: 2),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite sua senha";
                      }
                      if (value.length < 6) {
                        return "A senha deve ter pelo menos 6 caracteres";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.normalSpacing),

                  // Campo de confirmar senha
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword, // Controla se o texto está oculto (+ segurança)
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: InputDecoration(
                      labelText: "Confirmar senha",
                      labelStyle: const TextStyle(color: CashFlowColors.textSecondaryColor),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: const Icon(Icons.password, color: CashFlowColors.textSecondaryColor),

                      suffixIcon: IconButton( // Botão para alternar visibilidade da senha
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                          color: CashFlowColors.textSecondaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),

                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),

                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),

                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor, width: 2),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirme sua senha";
                      }
                      if (value != _passwordController.text) {
                        return "As senhas não coincidem";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.largeSpacing),

                  // Botão de registro
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) { // Simulação de cadastro - teste (tirar depois)
                          context.go('/expenses'); // Navegação -> Go Router
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: CashFlowColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text("Cadastrar"),
                    ),
                  ),

                  const SizedBox(height: CashFlowSizes.normalSpacing),

                  // Link para voltar ao login
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        context.pop(); // Navegação -> Go Router
                      },

                      child: Text(
                        "Já é registrado? Faça seu login",
                        style: TextStyle(
                          color: CashFlowColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}