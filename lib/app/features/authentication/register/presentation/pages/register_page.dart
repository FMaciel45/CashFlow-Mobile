import 'package:cashflow/app/features/authentication/register/presentation/notifiers/register_state.dart';
import 'package:cashflow/app/features/authentication/register/register_providers.dart';
import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/register_form.dart';

class CashFlowRegisterScreen extends ConsumerStatefulWidget {
  const CashFlowRegisterScreen({super.key});

  @override
  ConsumerState<CashFlowRegisterScreen> createState() => _CashFlowRegisterScreenState();
}

class _CashFlowRegisterScreenState extends ConsumerState<CashFlowRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    ref.listen<RegisterState>(registerNotifierProvider, (previous, state) {
      if (state is RegisterSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );

        context.go('/expenses');

      } else if (state is RegisterError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    });

    return Scaffold(
      backgroundColor: CashFlowColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: TAppBarTheme.lightAppBarTheme.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("CashFlow"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: CashFlowSizes.mediumPadding,
          vertical: CashFlowSizes.largePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Crie sua conta",
              style: textTheme.headlineMedium?.copyWith(
                color: CashFlowColors.textPrimaryColor
              ),
            ),

            const SizedBox(height: CashFlowSizes.smallSpacing),

            Text(
              "Preencha os campos para criar sua conta",
              style: textTheme.bodyMedium?.copyWith(
                color: CashFlowColors.textSecondaryColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.largeSpacing),

            RegisterForm(
              formKey: _formKey,
              nameController: _nameController,
              emailController: _emailController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              obscurePassword: _obscurePassword,
              obscureConfirmPassword: _obscureConfirmPassword,
              onTogglePasswordVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },

              onToggleConfirmPasswordVisibility: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },

              onSubmit: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(registerNotifierProvider.notifier).register(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                }
              },
            ),

            const SizedBox(height: CashFlowSizes.normalSpacing),
            
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  "Já é registrado? Faça seu login",
                  style: textTheme.bodySmall?.copyWith(
                    color: CashFlowColors.primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}