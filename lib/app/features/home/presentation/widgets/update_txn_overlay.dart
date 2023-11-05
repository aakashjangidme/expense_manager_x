import 'package:expense_manager_x/app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/transaction_info.dart';
import '../providers/transaction_provider.dart';

class UpdateTransactionOverlay extends ConsumerStatefulWidget {
  const UpdateTransactionOverlay({super.key, required this.txnId});

  final int txnId;

  @override
  ConsumerState<UpdateTransactionOverlay> createState() =>
      _UpdateTransactionOverlayState();
}

class _UpdateTransactionOverlayState
    extends ConsumerState<UpdateTransactionOverlay> {
  final TextEditingController _txnTitleController = TextEditingController();
  String _selectedTxnCategory = "";
  late TransactionInfo txnInfo;

  @override
  void initState() {
    super.initState();

    txnInfo = ref
        .read(filteredTransactionsProvider)
        .value!
        .firstWhere((element) => element.id == widget.txnId);

    _txnTitleController.text = txnInfo.transactionTitle ?? "";
    _selectedTxnCategory = txnInfo.transactionCategory ?? "";
  }

  @override
  void dispose() {
    _txnTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update Transaction"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextField(
              controller: _txnTitleController,
              label: "what was it for?",
              hintText: "what was it for?",
            ),
            const SizedBox(height: 16.0),
            const Text("Category"),
            const SizedBox(height: 8.0),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: _buildCategoryPills(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            TransactionInfo updatedTxnInfo = txnInfo.copyWith(
                transactionTitle: _txnTitleController.text,
                transactionCategory: _selectedTxnCategory);
            if (_txnTitleController.text.isNotEmpty ||
                _selectedTxnCategory.isNotEmpty) {
              ref
                  .read(filteredTransactionsProvider.notifier)
                  .updateOriginalTransaction(updatedTxnInfo);
            }
            Navigator.of(context).pop(true);
          },
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
            setState(() {
              _selectedTxnCategory = category;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color:
                  _selectedTxnCategory == category ? Colors.blue : Colors.grey,
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
