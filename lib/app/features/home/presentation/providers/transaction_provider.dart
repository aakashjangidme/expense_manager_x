import 'dart:developer';
import 'dart:ffi';

import 'package:expense_manager_x/app/features/accounts/presentation/providers/account_screen_provider.dart';
import 'package:expense_manager_x/app/features/home/presentation/providers/sms_provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/configs/constants.dart';
import '../../domain/models/transaction_info.dart';
import '../../domain/providers/txn_repository_provider.dart';

part 'transaction_provider.g.dart';
/*
@riverpod
List<TransactionInfo> debitTransactions(DebitTransactionsRef ref) {
  final txnList = ref.watch(transactionListFromSMSIsolateProvider);
  log('debitTransactions::txnList.hasValue ${txnList.hasValue}');

  if (!txnList.hasValue) {
    return [];
  }

  return txnList.valueOrNull!
      .where((element) => element.txnType == TxnType.debit)
      .toList();
}
*/

// Provider for handling permission status
@riverpod
class SMSPermissionStatus extends _$SMSPermissionStatus {
  @override
  PermissionStatus build() => PermissionStatus.denied;

  void updatePermissionStatus(PermissionStatus permissionStatus) {
    state = permissionStatus;
  }
}

// Provider for updating transactions
@riverpod
class FilteredTransactions extends _$FilteredTransactions {
  @override
  Future<List<TransactionInfo>> build() async {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final debitTransactions = ref.watch(debitTransactionsProvider);

    List<TransactionInfo> filteredTransactions = [];

    log('debitTransactions.isEmpty ${debitTransactions.isEmpty}');
    log('debitTransactions.length ${debitTransactions.length}');

    if (debitTransactions.isNotEmpty) {
      filteredTransactions = debitTransactions.where((transaction) {
        final transactionDate = transaction.transactionDate;
        final formattedDate =
            DateFormat(defaultMonthFormat, 'en_US').format(transactionDate!);
        return (formattedDate == selectedMonth);
      }).toList();
    }

    // Sort the filtered transactions by transactionDate
    filteredTransactions
        .sort((a, b) => b.transactionDate!.compareTo(a.transactionDate!));

    filteredTransactions = filteredTransactions
        .where((element) => element.isDismissed == false)
        .toList();

    return filteredTransactions;
  }

  Future<void> updateOriginalTransaction(
      TransactionInfo updatedTransaction) async {
    state = state.whenData((value) => value.map((transaction) {
          if (transaction.id == updatedTransaction.id) {
            return transaction.copyWith(
              transactionCategory: updatedTransaction.transactionCategory,
              transactionTitle: updatedTransaction.transactionTitle,
            );
          }
          return transaction;
        }).toList());
  }
}

// Provider for the selected month
@riverpod
class SelectedMonth extends _$SelectedMonth {
  @override
  String build() {
    final uniqueMonths = ref.watch(uniqueMonthsProvider);
    if (uniqueMonths.isNotEmpty) {
      return uniqueMonths[0];
    }

    return DateFormat(defaultMonthFormat, 'en_US').format(DateTime.now());
  }

  void setSelectedMonth(String selectedMonth) {
    state = selectedMonth;
  }
}

// Provider for calculating total debits
@riverpod
double totalDebits(TotalDebitsRef ref) {
  final filteredTransactions = ref.watch(filteredTransactionsProvider);

  if (!filteredTransactions.hasValue) {
    return filteredTransactions.valueOrNull
            ?.where((transaction) => transaction.txnType == TxnType.debit)
            .map((transaction) => transaction.transactionAmount)
            .fold(0.0, (total, amount) => total! + amount!) ??
        0.0;
  }

  return filteredTransactions.valueOrNull!
      .where((transaction) => transaction.txnType == TxnType.debit)
      .map((transaction) => transaction.transactionAmount)
      .fold(0.0, (total, amount) => total + amount!);
}

@riverpod
double aggregateBalance(AggregateBalanceRef ref) {
  final accountList = ref.watch(accountListProvider);

  if (!accountList.hasValue) {
    return 0;
  }

  double totalBalance = 0.0;

  for (final account in accountList.requireValue) {
    totalBalance += account.accountBalance ?? 0.0;
  }

  return totalBalance;
}

// Provider for unique months
@riverpod
List<String> uniqueMonths(UniqueMonthsRef ref) {
  final txnList = ref.watch(transactionListFromSMSIsolateProvider);

  if (txnList.hasValue && txnList.value!.isNotEmpty) {
    final uniqueMonthsSet = <String>{};
    final minDate = txnList.value!
        .map((txn) => txn.transactionDate)
        .where((date) => date != null)
        .reduce((minDate, date) => minDate!.isBefore(date!) ? minDate : date);

    final currentDate = DateTime.now();
    final dateFormatter = DateFormat(defaultMonthFormat, 'en_US');
    final minMonth = dateFormatter.format(minDate!);
    final currentMonth = dateFormatter.format(currentDate);

    for (DateTime date = currentDate;
        date.isAfter(minDate!) || dateFormatter.format(date) == minMonth;
        date = DateTime(date.year, date.month - 1)) {
      uniqueMonthsSet.add(dateFormatter.format(date));
    }

    final uniqueMonthsList = uniqueMonthsSet.toList();
    uniqueMonthsList.sort(
        (a, b) => dateFormatter.parse(b).compareTo(dateFormatter.parse(a)));

    return uniqueMonthsList;
  }

  return [];
}

@riverpod
class DebitTransactions extends _$DebitTransactions {
  @override
  List<TransactionInfo> build() {
    final txnList = ref.watch(transactionListFromSMSIsolateProvider);

    if (!txnList.hasValue) {
      return txnList.valueOrNull ?? [];
    }

    return txnList.valueOrNull!
        .where((element) => element.txnType == TxnType.debit)
        .toList();
  }

  Future<void> addTransaction(TransactionInfo info) async {
    final txnRepo = ref.watch(transactionRepositoryProvider);

    await txnRepo.insertTransaction(info);

    final txnList = await txnRepo.getAllTransactions();

    state =
        txnList.where((element) => element.txnType == TxnType.debit).toList();
  }

  Future<void> deleteTransaction(TransactionInfo info) async {
    final txnRepo = ref.watch(transactionRepositoryProvider);

    await txnRepo.deleteTransaction(info);

    final txnList = await txnRepo.getAllTransactions();

    state = txnList
        .where((element) =>
            element.txnType == TxnType.debit && element.isDismissed == false)
        .toList();
  }

  Future<void> markTransactionAsDismissed(TransactionInfo info) async {
    final txnRepo = ref.watch(transactionRepositoryProvider);

    final txn = info.copyWith(isDismissed: true);

    await txnRepo.updateTransaction(txn);

    final txnList = await txnRepo.getAllTransactions();

    state =
        txnList.where((element) => element.txnType == TxnType.debit).toList();
  }
}
