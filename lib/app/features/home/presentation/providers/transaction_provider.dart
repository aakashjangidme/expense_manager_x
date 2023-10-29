import 'dart:developer';

import 'package:expense_manager_x/app/features/home/presentation/providers/sms_provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/configs/constants.dart';
import '../../domain/models/transaction_info.dart';

part 'transaction_provider.g.dart';

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
    // final smsMessagesProvider = ref.watch(sMSNotifierProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);
    final debitTransactions = ref.watch(debitTransactionsProvider);

    List<TransactionInfo> filteredTransactions = [];

    log('debitTransactions.isEmpty ${debitTransactions.isEmpty}');
    log('debitTransactions.length ${debitTransactions.length}');

    if (debitTransactions.isNotEmpty) {
      filteredTransactions = debitTransactions.where((transaction) {
        final transactionDate = transaction.transactionDate;
        final formattedDate =
            DateFormat(defaultMonthFormat, 'en_US').format(transactionDate);
        return formattedDate == selectedMonth;
      }).toList();
    }

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

  if (filteredTransactions.hasValue && filteredTransactions.asData != null) {
    final filteredData = filteredTransactions.asData;

    if (filteredData != null && filteredData.value.isNotEmpty) {
      return filteredData.value
          .where((transaction) => transaction.txnType == TxnType.debit)
          .map((transaction) => transaction.transactionAmount)
          .fold(0.0, (total, amount) => total + amount);
    }
  }

  return 0.0;
}

// Provider for unique months
@riverpod
List<String> uniqueMonths(UniqueMonthsRef ref) {
  final txnList = ref.watch(transactionListFromSMSIsolateProvider);

  if (txnList.hasValue) {
    final uniqueMonthsSet = <String>{};

    for (final txn in txnList.value!) {
      //TODO: come back here and see the usage of smsMessages.asData!.value
      final transactionDate = txn.transactionDate;
      final monthYearString =
          DateFormat(defaultMonthFormat, 'en_US').format(transactionDate);

      uniqueMonthsSet.add(monthYearString);
    }

    return uniqueMonthsSet.toList();
  }

  return [];
}
