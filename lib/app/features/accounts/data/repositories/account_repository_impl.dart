import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/mapper/transform_account.dart';
import '../../domain/models/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/local/hive/account_object.dart';

class AccountRepositoryImpl implements AccountRepository {
  final Box<AccountObject> _box;

  AccountRepositoryImpl({required Box<AccountObject> box}) : _box = box;

  @override
  Future<List<Account>> getAllAccounts() async {
    try {
      final accountEntities = _box.values.toList();
      return accountEntities.map(transformToAccount).toList();
    } catch (e) {
      log('AccountRepositoryImpl::getAllAccounts', error: e);
      rethrow;
    }
  }

  @override
  Future<void> insertAllAccounts(List<Account> accounts) async {
    try {
      final accountList = accounts.map(transformToAccountObject).toList();
      await _box.addAll(accountList);
    } catch (e) {
      log('AccountRepositoryImpl::insertAllAccounts', error: e);
      rethrow;
    }
  }

  @override
  Future<void> updateAccount(Account account) async {
    try {
      log('AccountRepositoryImpl::updateAccount.account - \n${account.toString()}');

      if (_box.containsKey(account.key)) {
        final updatedEntity = transformToAccountObject(account);
        await _box.put(account.key, updatedEntity);
      } else {
        final message =
            "AccountRepositoryImpl::updateAccount - The key ${account.key} does not exist.";
        throw AsyncValue.error(message, StackTrace.current);
      }
    } catch (e) {
      log('AccountRepositoryImpl::updateAccount', error: e);
      rethrow;
    }
  }

  @override
  Future<void> insertAccount(Account account) async {
    try {
      log('AccountRepositoryImpl::insertAccount.account - \n${account.toString()}');

      final existingAccount =
          _box.values.any((element) => element.id == account.id);

      if (!existingAccount) {
        final newAccount = transformToAccountObject(account);
        await _box.add(newAccount);
      } else {
        final message =
            "AccountRepositoryImpl::insertAccount - The id ${account.id} already exists.";
        throw AsyncValue.error(message, StackTrace.current);
      }
    } catch (e, s) {
      log('AccountRepositoryImpl::insertAccount', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount(Account account) async {
    try {
      log('AccountRepositoryImpl::deleteAccount.account - \n${account.toString()}');

      if (_box.containsKey(account.key)) {
        await _box.delete(account.key);
      } else {
        final message =
            "AccountRepositoryImpl::deleteAccount - The key ${account.key} does not exist.";
        throw AsyncValue.error(message, StackTrace.current);
      }
    } catch (e) {
      log('AccountRepositoryImpl::deleteAccount', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteAllAccounts() async {
    await _box.clear();
  }

  @override
  Future<Account?> getAccountById(Account account) async {
    try {
      final acc = transformToAccountObject(account);
      if (_box.containsKey(acc.key)) {
        final account = _box.getAt(acc.key);
        return transformToAccount(account!);
      }
      return null;
    } catch (e) {
      log('AccountRepositoryImpl::getAccountById', error: e);
      rethrow;
    }
  }
}
