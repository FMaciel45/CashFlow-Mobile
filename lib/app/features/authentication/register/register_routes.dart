import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'presentation/pages/register_page.dart';

class RegisterRoutes {
  static const String register = '/register';   // Constante para o caminho da rota

  // Lista de rotas registradas
  static final routes = [
    GoRoute(
      path: register,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const CashFlowRegisterScreen(), // Widget da tela
      ),
    ),
  ];
}