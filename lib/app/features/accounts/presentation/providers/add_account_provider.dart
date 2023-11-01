import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/account.dart';
import '../../domain/providers/account_repository_provider.dart';

part 'add_account_provider.g.dart';

class AddAccountsScreenStateObject {
  String? accountNumber;
  String? accountName;
  String? accountType;
  double? accountBalance;

  AddAccountsScreenStateObject({
    this.accountNumber,
    this.accountName,
    this.accountType,
    this.accountBalance,
  });

  AddAccountsScreenStateObject copyWith({
    String? accountNumber,
    String? accountName,
    String? accountType,
    double? accountBalance,
  }) {
    return AddAccountsScreenStateObject(
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      accountType: accountType ?? this.accountType,
      accountBalance: accountBalance ?? this.accountBalance,
    );
  }
}

// //add account screen state
@riverpod
class AddAccountsScreenState extends _$AddAccountsScreenState {
  final stateObject = AddAccountsScreenStateObject();

  @override
  AddAccountsScreenStateObject build() => stateObject;

  void setAccountType(String? accountType) {
    state = state.copyWith(accountType: accountType);
  }

  void setAccountNumber(String? accountNumber) {
    state = state.copyWith(accountNumber: accountNumber);
  }

  void setAccountName(String? accountName) {
    state = state.copyWith(accountName: accountName);
  }

  void setAccountBalance(String? accountBalance) {
    state = state.copyWith(
      accountBalance:
          accountBalance != null ? double.tryParse(accountBalance) : null,
    );
  }

  Future<void> saveAccount() async {
    final accountRepository = ref.watch(accountRepositoryProvider);

    final allAccounts = await accountRepository.getAllAccounts();

    int id = allAccounts.isNotEmpty ? (allAccounts.last.id ?? 0) + 1 : 0;

    final account = Account(
      id: id,
      accountNumber: state.accountNumber,
      accountName: state.accountName,
      accountType: state.accountType,
      accountBalance: state.accountBalance,
      totalDebitAmount: null,
      totalCreditAmount: null,
      key: null,
    );

    await accountRepository.insertAccount(account);

    log("account saved : ${account.toString()}");
  }
}
