import 'dart:developer';

import 'package:expense_manager_x/app/core/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/transaction_info.dart';
import '../providers/transaction_provider.dart';

class InputFieldDescription {
  final String label;
  final String value;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  final dynamic providerName;

  InputFieldDescription({
    required this.label,
    required this.value,
    required this.providerName,
    this.onSaved,
    this.validator,
  });
}

final fieldDescriptions = [
  InputFieldDescription(
      label: 'Amount',
      value: 'Amount',
      providerName: amountProvider,
      validator: (value) {
        if (value!.isEmpty) {
          return "enter some amount!";
        }
        return null;
      }),
  InputFieldDescription(
      label: 'What was it for?',
      value: 'What was it for?',
      providerName: titleProvider),
  InputFieldDescription(
    label: 'Source',
    value: 'Source',
    providerName: sourceProvider,
  ),

  // Add more input field descriptions here
];

final titleProvider = StateProvider.autoDispose<String?>((ref) => null);
final sourceProvider = StateProvider.autoDispose<String?>((ref) => null);
final typeProvider = StateProvider.autoDispose<TxnType>((ref) => TxnType.debit);
final amountProvider = StateProvider.autoDispose<String?>((ref) => null);
final categoryProvider = StateProvider.autoDispose<String>((ref) => '');

class AddTxnOverlay extends ConsumerStatefulWidget {
  const AddTxnOverlay({super.key});

  @override
  ConsumerState<AddTxnOverlay> createState() => _AddTxnOverlayState();
}

class _AddTxnOverlayState extends ConsumerState<AddTxnOverlay> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Data is valid, you can save the transaction
      // Create a TransactionInfo object and save it to your data store

      final String amt = ref.watch(amountProvider) ?? "0";
      final String txnTitle = ref.watch(titleProvider) ?? "";
      final String transactionSource = ref.watch(sourceProvider) ?? "";

      TransactionInfo newTxn = TransactionInfo(
        id: 940,
        // Replace with the appropriate ID
        transactionTitle: txnTitle.trim().isEmpty ? "Unknown" : txnTitle.trim(),
        txnType: ref.read(typeProvider),
        transactionSource:
            transactionSource.trim().isEmpty ? "" : transactionSource.trim(),
        transactionDate: DateTime.now(),
        transactionAmount: double.tryParse(amt) ?? 0,
        transactionCategory: ref.read(categoryProvider),
        txnBody: "",
      );

      log(newTxn.toString());

      await ref.read(debitTransactionsProvider.notifier).addTransaction(newTxn);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction saved successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        _formKey.currentState!.reset();
        Navigator.of(context).pop(true);
      }
    }
  }

  Widget _buildTextFormField(InputFieldDescription field) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final state = ref.watch(field.providerName!);
        return TextFormField(
          initialValue: state,
          decoration: InputDecoration(labelText: field.label),
          validator: field.validator,
          onSaved: (value) {
            ref.read(field.providerName!.notifier).state = value!;
          },
          keyboardType: field.label == 'Amount'
              ? TextInputType.number
              : TextInputType.text,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Transaction"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16.0),
              for (var field in fieldDescriptions) ...[
                _buildTextFormField(field),
                const SizedBox(height: 16.0),
              ],
              const SizedBox(height: 16.0),
              Text(
                "Transaction Type",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildTxnTypePills(),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Category",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 16.0),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                children: _buildCategoryPills(),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: _saveTransaction,
          child: const Text("Save"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  List<Widget> _buildCategoryPills() {
    final categories = [
      "Shopping",
      "Entertainment",
      "Bills",
      "Others"
    ]; // Define your categories here
    List<Widget> pills = [];
    for (final category in categories) {
      pills.add(
        GestureDetector(
          onTap: () {
            ref.read(categoryProvider.notifier).state = category;
          },
          child: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: ref.watch(categoryProvider) == category
                  ? Colors.blue
                  : Colors.grey,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(category),
          ),
        ),
      );
    }
    return pills;
  }

  List<Widget> _buildTxnTypePills() {
    final categories = [
      "Debit",
      "Credit",
    ]; // Define your categories here
    List<Widget> pills = [];
    for (final category in categories) {
      pills.add(
        GestureDetector(
          onTap: () {
            ref.read(typeProvider.notifier).state = category == "Credit"
                ? TxnType.credit
                : category == "Debit"
                    ? TxnType.debit
                    : TxnType.debit;
          },
          child: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: ref.watch(typeProvider).name.toUpperCase() ==
                      category.toUpperCase()
                  ? Colors.blue
                  : Colors.grey,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(category),
          ),
        ),
      );
    }
    return pills;
  }
}
