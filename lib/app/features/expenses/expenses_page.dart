import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';

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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appBarTheme = TAppBarTheme.lightAppBarTheme;

    return Scaffold(
      backgroundColor: CashFlowColors.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a seta de voltar (padrão)
        centerTitle: appBarTheme.centerTitle,
        backgroundColor: appBarTheme.backgroundColor,
        elevation: appBarTheme.elevation,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Olá, Felipe",
              style: textTheme.headlineSmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // ToDo -> implementar navegação para tela de perfil (alterar e-mail e/ou senha)
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CashFlowSizes.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceSection(), // Seção de saldo
            const SizedBox(height: CashFlowSizes.largeSpacing),
            ExpensesSection(), // Seção que exibe as despesas
            const SizedBox(height: CashFlowSizes.normalSpacing),
            ExpenseCard(), // Seção para os cards
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: CashFlowColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            context.push('/new-expense'); // Navegação p/ tela de adicionar despesa com Go Router
          },
        ),
      ),
    );
  }
}

// Seção que exibe o saldo total do usuário
class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: CashFlowSizes.mediumPadding),
          decoration: BoxDecoration(
            color: CashFlowColors.primaryBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seus gastos totais",
                style: textTheme.bodyMedium?.copyWith(
                  color: CashFlowColors.textSecondaryColor,
                ),
              ),

              const SizedBox(height: CashFlowSizes.xsmallSpacing),

              Text(
                "R\$ 2.651,70",
                style: textTheme.headlineMedium?.copyWith(
                  color: CashFlowColors.textPrimaryColor,
                ),
              ),

              TDividerTheme.lightDivider, // Alteração -> divider padronizado na pasta "themes"

            ],
          ),
        ),
      ],
    );
  }
}

// Seção que exibe os gastos atuais
class ExpensesSection extends StatelessWidget {
  const ExpensesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: CashFlowSizes.mediumPadding),
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
                style: textTheme.titleMedium?.copyWith(
                  color: CashFlowColors.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "R\$ 1.349,48",
                style: textTheme.titleMedium?.copyWith(
                  color: CashFlowColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "Gastos em Junho",
            style: textTheme.bodySmall?.copyWith(
              color: CashFlowColors.textSecondaryColor,
            ),
          ),
          const SizedBox(height: CashFlowSizes.smallSpacing),
        ],
      ),
    );
  }
}

// Lista de transações do usuário (cards)
class ExpenseCard extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [ // Dados para teste visual -> mock?
    {
      'id': '1',
      'title': 'iPhone',
      'date': '21 Mar 2024',
      'time': '15:30',
      'amount': '- R\$ 5.999,00',
      'icon': Icons.wallet,
    }
  ];

  ExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column( // Converte cada transação em um widget TransactionItem
      children: transactions.map((transaction) {
        return TransactionItem(
          transaction,
          key: ValueKey(transaction['id']),
          onDelete: () => _handleDelete(transaction['id'], context),
          onEdit: () => _handleEdit(transaction['id'], context),
        );
      }).toList(),
    );
  }

  void _handleDelete(String id, BuildContext context) { // ToDo -> comunicar com a API p/ deleção
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Despesa $id será apagada')),
    );
  }

  void _handleEdit(String id, BuildContext context) { // ToDo -> comunicar com a API para edição
    context.push('/edit-expense/$id'); // Navega p/ a tela de edição (Go Router) com o ID da despesa
  }
}

// Item individual presente na lista de transações
class TransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onDelete; // Callback para deletar
  final VoidCallback onEdit; // Callback para editar

  const TransactionItem(
    this.transaction, {
    super.key,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CashFlowSizes.smallSpacing),
      child: Slidable( // Slidable p/ botões de "editar" e "apagar"
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onEdit(),
              backgroundColor: CashFlowColors.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            SlidableAction(
              onPressed: (context) => onDelete(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Apagar',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ],
        ),
        child: Container( // Conteúdo de cada item
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CashFlowColors.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}