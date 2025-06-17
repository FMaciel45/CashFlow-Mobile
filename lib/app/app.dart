import 'package:flutter/material.dart';
import 'package:cashflow/app/features/theming/theme.dart';
import 'package:cashflow/app/features/routing/routes/app_router.dart';

class CashFlow extends StatelessWidget {
  const CashFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // themeMode: ThemeMode.light, // Força tema claro globalmente
      theme: CashFlowTheme.lightTheme,
      darkTheme: CashFlowTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router, // Usa o router configurado na clase AppRouter em app_router.dart 
    );
  }
}