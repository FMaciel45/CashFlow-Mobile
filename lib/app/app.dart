import 'package:cashflow/app/features/expenses/expenses_page.dart';
import 'package:flutter/material.dart';
import 'package:cashflow/app/features/theming/theme.dart';
import 'package:cashflow/app/features/authentication/login/login_page.dart';

class CashFlow extends StatelessWidget {
  const CashFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: CashFlowTheme.lightTheme,
      darkTheme: CashFlowTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: CashFlowExpensesScreen(), 
      //home: CashFlowLoginScreen(),
    );
  }
}