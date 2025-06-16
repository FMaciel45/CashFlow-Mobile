import 'package:go_router/go_router.dart';
import 'package:cashflow/app/features/authentication/register/register_page.dart';
import 'package:cashflow/app/features/authentication/login/login_page.dart';
import 'package:cashflow/app/features/expenses/expenses_page.dart';
import 'package:cashflow/app/features/expenses/new_expense_page.dart';

// Configuração da navegação do app usando Go Router

class AppRouter {
  static final router = GoRouter(
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
  );
}