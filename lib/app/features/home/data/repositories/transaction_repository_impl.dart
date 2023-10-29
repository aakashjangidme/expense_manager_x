import 'dart:developer';

import 'package:expense_manager_x/app/features/home/domain/repositories/transaction_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/mapper/transform_transaction.dart';
import '../../domain/models/transaction_info.dart';
import '../datasources/local/hive/transaction.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  late final Box<Transaction> _box;

  TransactionRepositoryImpl({required Box<Transaction> box}) : _box = box;

  // Retrieve all transactions from the database
  @override
  Future<List<TransactionInfo>> getAllTransactions() async {
    try {
      final transactionEntities = _box.values.toList();
      final transactionInfoList =
          transactionEntities.map(transformToTransactionInfo).toList();

      return transactionInfoList;
    } catch (e) {
      log('TransactionRepositoryImpl::getAllTransactions', error: e);
      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  // Insert multiple transactions into the database
  @override
  Future<void> insertAllTransactions(List<TransactionInfo> txnInfoList) async {
    try {
      final transactionList =
          txnInfoList.map(transformToTransactionObject).toList();
      await _box.addAll(transactionList);
    } catch (e) {
      log('TransactionRepositoryImpl::insertAllTransactions', error: e);

      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  // Update a transaction in the database
  @override
  Future<void> updateTransaction(TransactionInfo transactionInfo) async {
    try {
      log('TransactionRepositoryImpl::updateTransaction.transactionInfo - \n${transactionInfo.toString()}');

      if (_box.containsKey(transactionInfo.key)) {
        final updatedEntity = transformToTransactionObject(transactionInfo);
        await _box.put(transactionInfo.key, updatedEntity);
      } else {
        final message =
            "TransactionRepositoryImpl::updateTransaction - The key ${transactionInfo.key} does not exists.";
        throw AsyncValue.error(message, StackTrace.current);
      }
    } catch (e) {
      log('TransactionRepositoryImpl::updateTransaction', error: e);

      // Handle any exceptions, such as HiveException or others, appropriately
      // Logging the error or returning a default value may be considered
      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  // Insert a single transaction into the database
  @override
  Future<void> insertTransaction(TransactionInfo transactionInfo) async {
    try {
      log('TransactionRepositoryImpl::insertTransaction.transactionInfo - \n${transactionInfo.toString()}');

      final existingTransaction =
          _box.values.any((element) => element.id == transactionInfo.id);

      if (!existingTransaction) {
        final newTransaction = transformToTransactionObject(transactionInfo);
        await _box.add(newTransaction);
      } else {
        final message =
            "TransactionRepositoryImpl::insertTransaction - The key ${transactionInfo.key} already exists.";
        throw AsyncValue.error(message, StackTrace.current);
      }
    } catch (e, s) {
      log('TransactionRepositoryImpl::insertTransaction',
          error: e, stackTrace: s);
      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  // Delete a transaction from the database
  @override
  Future<void> deleteTransaction(TransactionInfo transactionInfo) async {
    try {
      log('TransactionRepositoryImpl::deleteTransaction.transactionInfo - \n${transactionInfo.toString()}');

      if (_box.containsKey(transactionInfo.key)) {
        await _box.delete(transactionInfo.key);
      } else {
        final message =
            "TransactionRepositoryImpl::deleteTransaction - The key ${transactionInfo.key} does not exists.";
        throw AsyncValue.error(message, StackTrace.current);
      }
    } catch (e) {
      log('TransactionRepositoryImpl::deleteTransaction', error: e);

      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  @override
  Future<void> deleteAllTransactions() async {
    await _box.clear();
  }

  @override
  TransactionInfo? getTransactionById(TransactionInfo transactionInfo) {
    Transaction txn = transformToTransactionObject(transactionInfo);

    var keys = _box.keys.toList().toString();
    log(keys);
    log(transactionInfo.id.toString());

    if (_box.containsKey(txn.key)) {
      final transaction = _box.getAt(txn.key);

      final transactionInfo = transformToTransactionInfo(transaction!);

      return transactionInfo;
    }

    return null;
  }
}
