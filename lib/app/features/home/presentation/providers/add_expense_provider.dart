import 'dart:developer';

import 'package:expense_manager_x/app/core/configs/constants.dart';
import 'package:expense_manager_x/app/features/home/domain/models/transaction_info.dart';
import 'package:expense_manager_x/app/features/home/presentation/providers/transaction_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_expense_provider.g.dart';

class AddExpenseScreenStateObject {
  final double? expenseAmount;
  final String? expenseTitle;
  final String? expenseSourceAccount;
  final String? expenseType;
  final String? expenseCategory;

  AddExpenseScreenStateObject({
    this.expenseAmount,
    this.expenseTitle,
    this.expenseSourceAccount,
    this.expenseType = "Debit",
    this.expenseCategory,
  });

  AddExpenseScreenStateObject copyWith({
    double? expenseAmount,
    String? expenseTitle,
    String? expenseSourceAccount,
    String? expenseType,
    String? expenseCategory,
  }) {
    return AddExpenseScreenStateObject(
      expenseAmount: expenseAmount ?? this.expenseAmount,
      expenseTitle: expenseTitle ?? this.expenseTitle,
      expenseSourceAccount: expenseSourceAccount ?? this.expenseSourceAccount,
      expenseType: expenseType ?? this.expenseType,
      expenseCategory: expenseCategory ?? this.expenseCategory,
    );
  }
}

// //add account screen state
@riverpod
class AddExpenseScreenState extends _$AddExpenseScreenState {
  final stateObject = AddExpenseScreenStateObject();

  @override
  AddExpenseScreenStateObject build() => stateObject;

  void setExpenseAmount(String? expenseAmount) {
    state = state.copyWith(
      expenseAmount:
          expenseAmount != null ? double.tryParse(expenseAmount) : null,
    );
  }

  void setExpenseTitle(String? expenseTitle) {
    state = state.copyWith(expenseTitle: expenseTitle);
  }

  void setExpenseSourceAccount(String? expenseSourceAccount) {
    state = state.copyWith(expenseSourceAccount: expenseSourceAccount);
  }

  void setExpenseType(String? expenseType) {
    state = state.copyWith(expenseType: expenseType);
  }

  void setExpenseCategory(String? expenseCategory) {
    state = state.copyWith(expenseCategory: expenseCategory);
  }

  Future<void> saveExpense() async {
    final debitTxnNotifier = ref.read(debitTransactionsProvider.notifier);

    final debitTxn = ref.watch(debitTransactionsProvider);

    int? maxId = debitTxn.isNotEmpty
        ? debitTxn.map((entity) => entity.id).reduce((a, b) => a! > b! ? a : b)
        : 0;

    final txn = TransactionInfo(
      transactionAmount: state.expenseAmount,
      transactionCategory: state.expenseCategory,
      transactionDate: DateTime.now(),
      transactionSource: state.expenseSourceAccount,
      transactionTitle: state.expenseTitle,
      txnType: TxnType.debit,
      id: maxId! + 100,
    );

    await debitTxnNotifier.addTransaction(txn);

    log("txn saved : ${txn.toString()}");
  }
}
