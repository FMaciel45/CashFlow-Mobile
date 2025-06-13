import 'package:cashflow/app/features/expenses/new_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/* 
  Melhorias/ToDos:
  - Integrar c/ API (.NET) 
  - Separar responsabilidades
  - Refatorar o que puder 
  - Implementar light/dark theme
  - Implementar validações
  - Implementar os pacotes/libs recomendadas
  - Gestão de estado -> pesquisar
  - Testes -> widgets e integração
*/

class CashFlowExpensesScreen extends StatelessWidget {
  const CashFlowExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CashFlowColors.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a seta de voltar (padrão)
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Olá, Felipe",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CashFlowColors.textWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: CashFlowColors.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.profile_circle, color: Colors.white),
            onPressed: () {}, // ToDo -> implementar navegação para tela de perfil (alterar e-mail e/ou senha)
          ),
        ],
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CashFlowSizes.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Saldo
            _buildBalanceSection(context),
            const SizedBox(height: CashFlowSizes.largeSpacing),
            
            // Seção de Gastos
            _buildExpensesSection(context),
            const SizedBox(height: CashFlowSizes.normalSpacing),
            
            // Lista de Gastos
            _buildTransactionList(),
          ],
        ),
      ),

      floatingActionButton: Container(
        padding: const EdgeInsets.all(6), // Aumentar um pouco o tamanho do botão "+"
        decoration: BoxDecoration(
          color: CashFlowColors.primaryColor, 
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CashFlowNewExpenseScreen())
            );
          },
        ),
      ),
    );
  }

  Widget _buildBalanceSection(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity, // Largura total
          padding: const EdgeInsets.only(left: CashFlowSizes.mediumPadding, right: CashFlowSizes.mediumPadding),
          decoration: BoxDecoration(
            color: CashFlowColors.primaryBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seus gastos totais",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CashFlowColors.textSecondaryColor,
                ),
              ),

              const SizedBox(height: CashFlowSizes.smallSpacing),

              Text(
                "R\$ 2.651,70",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: CashFlowColors.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 24, 
          thickness: 1, 
          color: CashFlowColors.dividerColor, 
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }

  Widget _buildExpensesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: CashFlowSizes.mediumPadding, right: CashFlowSizes.mediumPadding),
      decoration: BoxDecoration(
        color: CashFlowColors.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Atividades",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: CashFlowColors.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "R\$ 1.349,48",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: CashFlowColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "Gastos em Junho",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: CashFlowColors.textSecondaryColor,
            ),
          ),
          const SizedBox(height: CashFlowSizes.smallSpacing),
        ],
      ),
    );
  }

  Widget _buildTransactionList() { // Dados de exemplo (mock?) -> serão substituídos pela API futuramente
    final transactions = [
      {
        'title': 'iPhone',
        'date': '21 Mar 2024',
        'time': '15:30',
        'amount': '- R\$ 5.999,00',
        'icon': Iconsax.wallet,
      },
      {
        'title': 'Mercado',
        'date': '18 Mar 2024',
        'time': '02:15',
        'amount': '- R\$ 349,48',
        'icon': Iconsax.wallet,
      },
    ];

    // Converte cada transação em um Widget
    return Column(
      children: transactions.map((transaction) => _buildTransactionItem(transaction)).toList(),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) { // Transaction -> mapa com dados da transação p/ serem consumidos pela API futuramente
    return Container(
      margin: const EdgeInsets.only(bottom: CashFlowSizes.smallSpacing),
      padding: const EdgeInsets.all(CashFlowSizes.mediumPadding),
      decoration: BoxDecoration(
        color: CashFlowColors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CashFlowColors.primaryColorWithLessOpacity,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              transaction['icon'] as IconData,
              color: CashFlowColors.primaryColor,
            ),
          ),
          const SizedBox(width: CashFlowSizes.mediumPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CashFlowColors.textPrimaryColor,
                  ),
                ),
                Text(
                  "${transaction['date']} | ${transaction['time']}",
                  style: TextStyle(
                    color: CashFlowColors.textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            transaction['amount'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CashFlowColors.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}