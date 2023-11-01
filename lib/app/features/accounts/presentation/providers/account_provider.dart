import 'dart:developer';

import 'package:expense_manager_x/app/features/accounts/domain/providers/account_repository_provider.dart';
import 'package:expense_manager_x/app/features/accounts/presentation/screens/accounts_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/account.dart';

part 'account_provider.g.dart';

@riverpod
Future<List<Account>> accountList(AccountListRef ref) {
  final accountsRepository = ref.watch(accountRepositoryProvider);

  return accountsRepository.getAllAccounts();
}
