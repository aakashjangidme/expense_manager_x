import 'dart:developer';


import 'package:expense_manager_x/app/shared/extentions/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/account.dart';
import '../../domain/providers/account_repository_provider.dart';
import 'state/add_account_screen_state.dart';

part 'add_account_provider.g.dart';



// //add account screen state
@riverpod
class AddAccountsScreenState extends _$AddAccountsScreenState {
  @override
  AddAccountsScreenStateObject build() => AddAccountsScreenStateObject();

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
      accountBalance: accountBalance?.toDouble(),
    );
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setErrorMessage(String? errorMessage) {
    state = state.copyWith(error: errorMessage);
  }

  Future<void> saveAccount() async {
    setLoading(true);

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

    await Future.delayed(const Duration(seconds: 3));

    log("account saved : ${account.toString()}");

    setLoading(false);

    state = AddAccountsScreenStateObject();
  }
}
