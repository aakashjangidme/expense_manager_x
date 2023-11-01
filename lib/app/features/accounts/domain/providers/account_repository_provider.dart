import 'dart:developer';

import 'package:expense_manager_x/app/features/accounts/data/datasources/local/hive/account_object.dart';
import 'package:expense_manager_x/app/features/accounts/domain/repositories/account_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/account_repository_impl.dart';

part 'account_repository_provider.g.dart';

@riverpod
Box<AccountObject> accountAdapter(AccountAdapterRef ref) {
  return Hive.box<AccountObject>('accounts');
}

@riverpod
AccountRepository accountRepository(AccountRepositoryRef ref) {
  final datasource = ref.watch(accountAdapterProvider);
  log('datasource.isEmpty ${datasource.isEmpty}');
  return AccountRepositoryImpl(box: datasource);
}
