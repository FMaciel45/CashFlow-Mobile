import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:flutter/material.dart';
import 'package:cashflow/app/features/constants/styling.dart';
import 'package:go_router/go_router.dart';

class CashFlowUserPersonalizationScreen extends StatefulWidget {
  const CashFlowUserPersonalizationScreen({super.key});

  @override
  State<CashFlowUserPersonalizationScreen> createState() => _CashFlowUserPersonalizationScreenState();
}

class _CashFlowUserPersonalizationScreenState extends State<CashFlowUserPersonalizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  String? _errorMessage;
  String? _passwordErrorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    try {
      // Simular chamada à API (GET -> /api/user)
      final response = await Future.delayed(const Duration(seconds: 1), () {
        return {
          "name": "Usuário Exemplo",
          "email": "usuario@example.com"
        };
      });
      
      _nameController.text = response["name"]!;
      _emailController.text = response["email"]!;
      
      setState(() {
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Falha ao carregar dados do usuário";
      });
    } 
  }

  Future<void> _updateUserData() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _errorMessage = null;
    });
    
    try {
      // Simular chamada à API (PUT -> /api/User/change-password)
      await Future.delayed(const Duration(seconds: 1), () {
        return {
          "status": 204
        };
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dados atualizados com sucesso!"))
      );
    } catch (e) {
      setState(() {
        _errorMessage = "Falha ao atualizar dados do usuário";
      });
    }
  }

  Future<void> _changePassword() async {
    if (!_passwordFormKey.currentState!.validate()) return;
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordErrorMessage = "As senhas não coincidem";
      });
      return;
    }
    
    setState(() {
      _passwordErrorMessage = null;
    });
    
    try {
      // Simular chamada à API (PUT -> /api/User/change-password)
      await Future.delayed(const Duration(seconds: 1), () {
        return {
          "status": 204
        };
      });
      
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Senha alterada com sucesso!"))
      );
    } catch (e) {
      setState(() {
        _passwordErrorMessage = "Falha ao alterar senha. Verifique sua senha atual.";
      });
    }
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,

      builder: (context) => AlertDialog(
        title: const Text("Confirmar exclusão"),
        content: const Text("Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),

          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Excluir", style: TextStyle(color: CashFlowColors.errorColor)),
          ),
        ],
      ),
    );
    
    if (confirmed != true) return;
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        context.go("/login");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Falha ao excluir conta. Tente novamente mais tarde."))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appBarTheme = TAppBarTheme.lightAppBarTheme;
    
    final textFieldColor = CashFlowColors.textSecondaryColor;

    return Scaffold(
      backgroundColor: CashFlowColors.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a seta de voltar (padrão)
        backgroundColor: appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text("CashFlow"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: CashFlowSizes.mediumPadding,
          vertical: CashFlowSizes.largePadding,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "Voltar",
                  style: textTheme.bodyMedium?.copyWith(
                    color: CashFlowColors.primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Text(
              "Configurações de Usuário",
              style: textTheme.headlineMedium?.copyWith(
                color: CashFlowColors.textPrimaryColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.xsmallSpacing),

            Text(
              "Personalize informações do seu usuário",
              style: textTheme.bodyMedium?.copyWith(
                color: CashFlowColors.textSecondaryColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.largeSpacing),
                  
            Center(
              child: Icon(
                Icons.account_circle,
                color: CashFlowColors.primaryColor,
                size: CashFlowSizes.profileIconSize,
              ),
            ),

            const SizedBox(height: CashFlowSizes.largeSpacing),
                  
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: textFieldColor),
                    decoration: InputDecoration(
                      labelText: "Nome",
                      labelStyle: TextStyle(
                        color: textFieldColor,
                        fontSize: 16,
                      ),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.person, color: textFieldColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, insira seu nome";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.mediumSpacing),

                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: textFieldColor),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: textFieldColor,
                        fontSize: 16,
                      ),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.email, color: textFieldColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, insira seu email";
                      }
                      if (!value.contains("@")) {
                        return "Por favor, insira um email válido";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.mediumSpacing),
                        
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: CashFlowSizes.mediumSpacing),
                      child: Text(
                        _errorMessage!,
                        style: textTheme.bodySmall?.copyWith(color: CashFlowColors.errorColor),
                      ),
                    ),
                        
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateUserData,
                      child: const Text("Salvar Alterações"),
                    ),
                  ),
                ],
              ),
            ),
                  
            const SizedBox(height: CashFlowSizes.xlargeSpacing),

            const Divider(),

            const SizedBox(height: CashFlowSizes.mediumSpacing),
                  
            Text(
              "Alterar Senha",
              style: textTheme.titleLarge?.copyWith(
                color: CashFlowColors.textPrimaryColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.mediumSpacing),
                  
            Form(
              key: _passwordFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _currentPasswordController,
                    style: TextStyle(color: textFieldColor),
                    decoration: InputDecoration(
                      labelText: "Senha Atual",
                      labelStyle: TextStyle(
                        color: textFieldColor,
                        fontSize: 16,
                      ),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.lock, color: textFieldColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                    ),
                    obscureText: true,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, insira sua senha atual";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.mediumSpacing),

                  TextFormField(
                    controller: _newPasswordController,
                    style: TextStyle(color: textFieldColor),
                    decoration: InputDecoration(
                      labelText: "Nova Senha",
                      labelStyle: TextStyle(
                        color: textFieldColor,
                        fontSize: 16,
                      ),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.lock_outline, color: textFieldColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                    ),
                    obscureText: true,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, insira uma nova senha";
                      }
                      if (value.length < 6) {
                        return "A senha deve ter pelo menos 6 caracteres";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.mediumSpacing),

                  TextFormField(
                    controller: _confirmPasswordController,
                    style: TextStyle(color: textFieldColor),
                    decoration: InputDecoration(
                      labelText: "Confirmar Nova Senha",
                      labelStyle: TextStyle(
                        color: textFieldColor,
                        fontSize: 16,
                      ),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.lock_outline, color: textFieldColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textFieldColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.errorColor),
                      ),
                    ),
                    obscureText: true,
                    
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, confirme sua nova senha";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.mediumSpacing),
                        
                  if (_passwordErrorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: CashFlowSizes.mediumSpacing),
                      child: Text(
                        _passwordErrorMessage!,
                        style: textTheme.bodySmall?.copyWith(color: CashFlowColors.errorColor),
                      ),
                    ),
                        
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _changePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CashFlowColors.secondaryColor,
                      ),
                      child: const Text("Alterar Senha"),
                    ),
                  ),
                ],
              ),
            ),
                  
            const SizedBox(height: CashFlowSizes.xlargeSpacing),

            const Divider(),

            const SizedBox(height: CashFlowSizes.mediumSpacing),
                  
            Text(
              "Excluir Conta",
              style: textTheme.titleLarge?.copyWith(
                color: CashFlowColors.errorColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.smallSpacing),

            Text(
              "Esta ação removerá permanentemente sua conta e todos os dados associados.",
              style: textTheme.bodySmall?.copyWith(
                color: CashFlowColors.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: CashFlowSizes.mediumSpacing),
                  
            SizedBox(
              child: OutlinedButton(
                onPressed: _deleteAccount,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: CashFlowColors.errorColor),
                ),
                child: const Text(
                  "Excluir Minha Conta",
                  style: TextStyle(color: CashFlowColors.errorColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}