import 'package:cashflow/app/features/authentication/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/* 
  Melhorias/ToDos:
  - Integrar c/ API (.NET) 
  - Separar responsabilidades
  - Refatorar o que puder 
  - Implementar light/dark theme
  - Melhorar validações
  - Implementar os pacotes/libs recomendadas
  - Animar botão de entrar (loading - progress indicator)
*/

class CashFlowLoginScreen extends StatefulWidget {
  const CashFlowLoginScreen({super.key});

  @override
  State<CashFlowLoginScreen> createState() => _CashFlowLoginScreenState();
}

class _CashFlowLoginScreenState extends State<CashFlowLoginScreen> {
  /*
   Chave global (_formKey) para validação e controle do formulário
   - Chave global que mantém uma referência ao estado do widget Form
   - Permite validação do formulário
  */
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // Controller p/ senha e estado p/ controlar sua visibilidade
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Dispose -> limpeza de recursos (evita vazamentos de memória)
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Método principal de construção da interface
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtém o tema atual da página para manter consistência visual
    
    return Scaffold(
      backgroundColor: CashFlowColors.primaryBackgroundColor,
      appBar: AppBar( // Barra superior do app
        centerTitle: true,
        title: const Text(
          "CashFlow",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CashFlowColors.textWhiteColor,
          ),
        ),
        backgroundColor: CashFlowColors.primaryColor,
        elevation: 0, // Remove a sombra do AppBar
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: CashFlowSizes.mediumPadding,
          vertical: CashFlowSizes.largePadding,
        ),

        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
          children: [

            // Título
            Text(
              "Bem-vindo(a) de volta",
              style: theme.textTheme.headlineMedium?.copyWith(
                color: CashFlowColors.textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: CashFlowSizes.normalSpacing), // Espaçamento (margin?)

            // Subtítulo
            Text(
              "Faça login para continuar usando o CashFlow",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: CashFlowColors.textSecondaryColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.largeSpacing),

            // Formulário
            Form(
              key: _formKey, // Chave para controle do formulário
              child: Column(
                children: [

                  // Campo de e-mail
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress, // Otimização p/ o input de e-mail (teclado)
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: const InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Iconsax.direct_right, color: CashFlowColors.textSecondaryColor),
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

                    // Validadores (separar depois)
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
                    obscureText: _obscurePassword, // Controla se o texto está oculto (+ segurança)
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: const TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: const Icon(Iconsax.password_check, color: CashFlowColors.textSecondaryColor),

                      // Botão para alternar visibilidade da senha
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                          color: CashFlowColors.textSecondaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword; // Alterna o estado
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

                    // Validadores (separar depois e adicionar mais)
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite sua senha";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.largeSpacing),

                  // Botão de login
                  SizedBox(
                    width: double.infinity, // Ocupa toda a largura
                    child: ElevatedButton(
                      onPressed: () { // Valida o formulário quando pressionado
                        if (_formKey.currentState!.validate()) { // Testar o retorno do login - tirar depois
                          print('Login com: ${_emailController.text} / ${_passwordController.text}'); 
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: CashFlowColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text("Entrar"),
                    ),
                  ),

                  const SizedBox(height: CashFlowSizes.normalSpacing),

                  // Link p/ tela de registro
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push( // Navegação p/ tela de registro
                          context,
                          MaterialPageRoute(builder: (context) => const CashFlowRegisterScreen()),
                        );
                      },

                      child: Text(
                        "Não possui uma conta? Cadastre-se",
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