import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final VoidCallback onSubmit;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          
          // Nome
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
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

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Digite seu nome";
              }
              return null;
            },
          ),

          const SizedBox(height: CashFlowSizes.normalSpacing),

          // E-mail
          TextFormField(
            controller: emailController,
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

              if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                return "E-mail inválido (ex: nome@provedor.com)";
              }
              return null;
            },
          ),

          const SizedBox(height: CashFlowSizes.normalSpacing),

          // Senha
          TextFormField(
            controller: passwordController,
            obscureText: obscurePassword,
            style: const TextStyle(color: CashFlowColors.textSecondaryColor),
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: const TextStyle(color: CashFlowColors.textSecondaryColor),
              floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
              prefixIcon: const Icon(Icons.password, color: CashFlowColors.textSecondaryColor),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: CashFlowColors.textSecondaryColor,
                ),
                onPressed: onTogglePasswordVisibility,
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

          // Confirmar Senha
          TextFormField(
            controller: confirmPasswordController,
            obscureText: obscureConfirmPassword,
            style: const TextStyle(color: CashFlowColors.textSecondaryColor),
            decoration: InputDecoration(
              labelText: "Confirmar senha",
              labelStyle: const TextStyle(color: CashFlowColors.textSecondaryColor),
              floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
              prefixIcon: const Icon(Icons.password, color: CashFlowColors.textSecondaryColor),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  color: CashFlowColors.textSecondaryColor,
                ),
                onPressed: onToggleConfirmPasswordVisibility,
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
              if (value != passwordController.text) {
                return "As senhas não coincidem";
              }
              return null;
            },
          ),

          const SizedBox(height: CashFlowSizes.largeSpacing),

          // Botão de Cadastrar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubmit,
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
        ],
      ),
    );
  }
}