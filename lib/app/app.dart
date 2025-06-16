import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cashflow/app/features/theming/theme.dart';
import 'package:cashflow/app/features/authentication/login/login_page.dart';
import 'package:cashflow/app/features/authentication/register/register_page.dart';
import 'package:cashflow/app/features/expenses/expenses_page.dart';
import 'package:cashflow/app/features/expenses/new_expense_page.dart';

class CashFlow extends StatelessWidget {
  const CashFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter( // Navegação com Go Router
      routes: [
        GoRoute(
          path: '/',
          name: 'login',
          builder: (context, state) => const CashFlowLoginScreen(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const CashFlowRegisterScreen(),
        ),
        GoRoute(
          path: '/expenses',
          name: 'expenses',
          builder: (context, state) => const CashFlowExpensesScreen(),
        ),
        GoRoute(
          path: '/new-expense',
          name: 'new-expense',
          builder: (context, state) => const CashFlowNewExpenseScreen(),
        ),
      ],
      initialLocation: '/',
      debugLogDiagnostics: true, // Opcional (debug)
    );

    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: CashFlowTheme.lightTheme,
      darkTheme: CashFlowTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}