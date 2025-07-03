import 'package:cashflow/app/features/authentication/register/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cashflow/app/features/expenses/edit_expense_page.dart';
import 'package:cashflow/app/features/personalization/user_personalization_page.dart';
import 'package:cashflow/app/features/authentication/login/login_page.dart';
import 'package:cashflow/app/features/expenses/expenses_page.dart';
import 'package:cashflow/app/features/expenses/new_expense_page.dart';

// Provider principal do roteador - compatível com o Riverpod
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CashFlowLoginScreen(),
        ),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CashFlowRegisterScreen(),
        ),
      ),
      GoRoute(
        path: '/expenses',
        name: 'expenses',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CashFlowExpensesScreen(),
        ),
      ),
      GoRoute(
        path: '/new-expense',
        name: 'new-expense',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CashFlowNewExpenseScreen(),
        ),
      ),
      GoRoute(
        path: '/edit-expense/:id',
        name: 'edit-expense',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: CashFlowEditExpenseScreen(
            expenseId: state.pathParameters['id']!,
          ),
        ),
      ),
      GoRoute(
        path: '/user',
        name: 'user-page',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CashFlowUserPersonalizationScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Página não encontrada',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    ),
  );
});