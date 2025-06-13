import 'package:cashflow/app/features/constants/styling.dart';
import 'package:cashflow/app/features/expenses/expenses_page.dart';
import 'package:flutter/material.dart';
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

class CashFlowNewExpenseScreen extends StatefulWidget {
  const CashFlowNewExpenseScreen({super.key});

  @override
  State<CashFlowNewExpenseScreen> createState() => _CashFlowNewExpenseScreenState();
}

// Enum que representa os tipos de pagamento (feito para conversar com o backend .NET)
enum PaymentType {
  cash(0, 'Dinheiro', Iconsax.money),
  creditCard(1, 'Cartão de Crédito', Iconsax.card),
  debitCard(2, 'Cartão de Débito', Iconsax.card),
  electronicTransfer(3, 'Transferência', Iconsax.money_send);

  final int value; // Valor numérico p/ consumo pela API
  final String description;
  final IconData icon;

  const PaymentType(this.value, this.description, this.icon);
}

PaymentType? _selectedPaymentType;

class _CashFlowNewExpenseScreenState extends State<CashFlowNewExpenseScreen> {
  // Chave para controle e validação do formulário
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  
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
              style: theme.textTheme.titleLarge?.copyWith(
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
            SizedBox(
              child: TextButton(
                onPressed: () {
                  Navigator.push( // Navegação p/ tela anterior
                    context,
                    MaterialPageRoute(builder: (context) => const CashFlowExpensesScreen()),
                  );
                },
                child: Text(
                  "Voltar",
                  style: TextStyle(
                    color: CashFlowColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: CashFlowSizes.xsmallPadding),

            Text(
              "Adicionar despesa",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: CashFlowColors.textPrimaryColor,
              ),
            ),

            Text(
              "Adicione uma nova despesa",
              style: theme.textTheme.bodyMedium?.copyWith(
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
                      prefixIcon: Icon(Iconsax.textalign_left, color: CashFlowColors.textSecondaryColor),
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
                      prefixIcon: Icon(Iconsax.note_text, color: CashFlowColors.textSecondaryColor),
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
                      prefixIcon: Icon(Iconsax.money, color: CashFlowColors.textSecondaryColor),
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
                          Navigator.pop(context);
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