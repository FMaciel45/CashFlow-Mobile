import 'package:flutter/material.dart';
import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/theming/themes/cash_flow_themes.dart';
import 'package:go_router/go_router.dart';

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

class CashFlowNewExpenseScreen extends StatefulWidget {
  const CashFlowNewExpenseScreen({super.key});

  @override
  State<CashFlowNewExpenseScreen> createState() => _CashFlowNewExpenseScreenState();
}

// Enum que representa os tipos de pagamento (feito para conversar com o backend .NET)
enum PaymentType {
  cash(0, 'Dinheiro', Icons.money_rounded),
  creditCard(1, 'Cartão de Crédito', Icons.credit_card),
  debitCard(2, 'Cartão de Débito', Icons.credit_card),
  electronicTransfer(3, 'Transferência', Icons.send);

  final int value; // Valor numérico p/ consumo pela API
  final String description;
  final IconData icon;

  const PaymentType(this.value, this.description, this.icon);
}

class _CashFlowNewExpenseScreenState extends State<CashFlowNewExpenseScreen> {
  // Chave para controle e validação do formulário
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  PaymentType? _selectedPaymentType;
  
  @override
  void dispose() {
    // Limpeza dos controllers -> evitar vazamentos de memória
    _titleController.dispose();
    _descriptionController.dispose();
    _valueController.dispose();
    super.dispose();
  }

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
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CashFlowSizes.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: TextButton(
                onPressed: () {
                  context.pop(); // Navegação -> Go Router
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
              "Adicionar despesa",
              style: textTheme.headlineMedium?.copyWith(
                color: CashFlowColors.textPrimaryColor,
                fontWeight: FontWeight.bold
              ),
            ),

            Text(
              "Adicione uma nova despesa",
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

                            const SizedBox(height: CashFlowSizes.smallSpacing),

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

                  // Botão de Salvar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Formatar os dados para enviar à API
                          final expenseData = {
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'amount': double.parse(_valueController.text),
                            'paymentType': _selectedPaymentType?.value,
                            'date': DateTime.now().toIso8601String(),
                          };
                          
                          // Print para simulação da resposta 
                          // Aqui deve ser chamada a API no futuro
                          print('Dados da despesa: $expenseData');
                          
                          // Feedback (erro ou sucesso) e voltar p/ home
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Despesa adicionada com sucesso!')),
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
                      child: const Text("Salvar Despesa"),
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