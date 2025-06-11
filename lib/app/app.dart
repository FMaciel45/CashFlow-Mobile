import 'package:flutter/material.dart';
import 'package:cashflow/app/utils/theme/theme.dart';

class CashFlow extends StatelessWidget {
  const CashFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: CashFlowTheme.lightTheme,
      darkTheme: CashFlowTheme.darkTheme,
    );
  }
}