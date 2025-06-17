import 'package:flutter/material.dart';
import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:go_router/go_router.dart';

/* 
  Melhorias/ToDos:
  - Integrar c/ API (.NET) para buscar e atualizar a despesa
  - Separar responsabilidades
  - Refatorar o que puder 
  - Implementar light/dark theme
  - Implementar validações
  - Implementar os pacotes/libs recomendadas
  - Gestão de estado -> pesquisar
  - Testes -> widgets e integração
*/

class CashFlowEditExpenseScreen extends StatefulWidget {
  final String expenseId; // ID da despesa que será editada
  
  const CashFlowEditExpenseScreen({
    super.key,
    required this.expenseId,
  });

  @override
  State<CashFlowEditExpenseScreen> createState() => _CashFlowEditExpenseScreenState();
}

// Reutilizando o enum PaymentType da tela de nova despesa
enum PaymentType {
  cash(0, 'Dinheiro', Icons.money_rounded),
  creditCard(1, 'Cartão de Crédito', Icons.credit_card),
  debitCard(2, 'Cartão de Débito', Icons.credit_card),
  electronicTransfer(3, 'Transferência', Icons.send);

  final int value;
  final String description;
  final IconData icon;

  const PaymentType(this.value, this.description, this.icon);

  // Método para converter valor numérico em enum
  static PaymentType? fromValue(int value) {
    try {
      return PaymentType.values.firstWhere((type) => type.value == value);
    } catch (e) {
      return null;
    }
  }
}

class _CashFlowEditExpenseScreenState extends State<CashFlowEditExpenseScreen> {
  // Chave para controle e validação do formulário
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  PaymentType? _selectedPaymentType;
  
  @override
  void initState() {
    super.initState();
    _loadExpenseData(); // Carrega os dados da despesa quando o widget é inicializado
  }

  @override
  void dispose() {
    // Limpeza dos controllers
    _titleController.dispose();
    _descriptionController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  // Método para carregar os dados da despesa (simulado)
  void _loadExpenseData() {
    // ToDo: Substituir por chamada à API para buscar os dados da despesa com widget.expenseId
    
    // Dados simulados -> buscar da API depois
    final expenseData = {
      'title': 'iPhone',
      'description': 'Compra do novo iPhone 15',
      'amount': '5999.00', 
      'paymentType': 1, 
    };

    // Preenche os campos com os dados existentes (acima)
    _titleController.text = (expenseData['title'] as String?) ?? '';
    _descriptionController.text = (expenseData['description'] as String?) ?? '';
    _valueController.text = (expenseData['amount'] as String?) ?? '';
    
    // Converte o valor numérico para o enum correspondente
    if (expenseData['paymentType'] != null) {
      setState(() {
        _selectedPaymentType = PaymentType.fromValue(expenseData['paymentType'] as int);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appBarTheme = TAppBarTheme.lightAppBarTheme;

    return Scaffold(
      backgroundColor: CashFlowColors.primaryBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            onPressed: () {}, // ToDo: implementar navegação para tela de perfil
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CashFlowSizes.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: TextButton( // Botão "voltar"
                onPressed: () {
                  context.pop(); // Volta para a tela anterior
                },
                child: Text(
                  "Voltar",
                  style: textTheme.bodyMedium?.copyWith(
                    color: CashFlowColors.primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            const SizedBox(height: CashFlowSizes.xsmallPadding),

            Text(
              "Editar despesa",
              style: textTheme.headlineMedium?.copyWith(
                color: CashFlowColors.textPrimaryColor,
                fontWeight: FontWeight.bold
              ),
            ),

            Text(
              "Edite os dados da despesa",
              style: textTheme.bodyMedium?.copyWith(
                color: CashFlowColors.textSecondaryColor,
              ),
            ),

            const SizedBox(height: CashFlowSizes.mediumSpacing),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Campo Título
                  TextFormField(
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: const InputDecoration(
                      labelText: "Título",
                      labelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.title, color: CashFlowColors.textSecondaryColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor, width: 2),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe um título";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.mediumSpacing),

                  // Campo Descrição
                  TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    maxLength: 200,
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: const InputDecoration(
                      labelText: "Descrição",
                      labelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.description, color: CashFlowColors.textSecondaryColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      counterStyle: TextStyle(
                        color: CashFlowColors.textSecondaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: CashFlowSizes.mediumSpacing),

                  // Campo Valor
                  TextFormField(
                    controller: _valueController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: CashFlowColors.textSecondaryColor),
                    decoration: const InputDecoration(
                      labelText: "Valor (R\$)",
                      labelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      prefixIcon: Icon(Icons.attach_money_rounded, color: CashFlowColors.textSecondaryColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor, width: 2),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o valor";
                      }
                      if (double.tryParse(value) == null) {
                        return "Valor inválido";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.mediumSpacing),

                  // Seletor de Tipo de Pagamento
                  DropdownButtonFormField<PaymentType>(
                    value: _selectedPaymentType,
                    decoration: const InputDecoration(
                      labelText: "Tipo de Pagamento",
                      labelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      floatingLabelStyle: TextStyle(color: CashFlowColors.textSecondaryColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CashFlowColors.textSecondaryColor, width: 2),
                      ),
                    ),
                    items: PaymentType.values.map((type) {
                      return DropdownMenuItem<PaymentType>(
                        value: type,
                        child: Row(
                          children: [
                            Icon(type.icon, color: CashFlowColors.textSecondaryColor),
                            const SizedBox(width: 12),
                            Text(type.description,
                              style: const TextStyle(color: CashFlowColors.textSecondaryColor)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (PaymentType? newValue) {
                      setState(() {
                        _selectedPaymentType = newValue;
                      });
                    },

                    validator: (value) {
                      if (value == null) {
                        return "Selecione o tipo de pagamento";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: CashFlowSizes.largeSpacing),

                  // Botão de Atualizar a despesa selecionada
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Formatar os dados para enviar à API
                          final updatedExpenseData = {
                            'id': widget.expenseId,
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'amount': double.parse(_valueController.text),
                            'paymentType': _selectedPaymentType?.value,
                            'date': DateTime.now().toIso8601String(), // Ou manter a data original (?)
                          };
                          
                          // Print para simulação da resposta 
                          // Aqui deve ser chamada a API 
                          print('Dados atualizados da despesa: $updatedExpenseData');
                          
                          // Feedback (erro ou sucesso) e voltar p/ home
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Despesa atualizada com sucesso!')),
                          );
                          context.go('/expenses'); // Navegação -> Go Router
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CashFlowColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Atualizar Despesa"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}