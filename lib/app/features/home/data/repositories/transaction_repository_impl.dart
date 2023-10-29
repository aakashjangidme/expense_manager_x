import 'dart:developer';

import 'package:expense_manager_x/app/features/home/domain/repositories/transaction_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/mapper/txn_entity_to_model.dart';
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
          transactionEntities.map(mapTransactionEntityToModel).toList();

      return transactionInfoList;
    } catch (e) {
      log('TransactionRepositoryImpl::getAllTransactions', error: e);
      // Handle any exceptions, such as HiveException or others, appropriately
      // Logging the error or returning a default value may be considered
      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  // Insert multiple transactions into the database
  @override
  Future<void> insertAllTransactions(List<TransactionInfo> txnInfoList) async {
    try {
      final transactionList =
          txnInfoList.map(mapTransactionModelToEntity).toList();
      await _box.addAll(transactionList);
    } catch (e) {
      log('TransactionRepositoryImpl::insertAllTransactions', error: e);

      // Handle any exceptions, such as HiveException or others, appropriately
      // Logging the error or returning a default value may be considered
      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  // Update a transaction in the database
  @override
  Future<void> updateTransaction(TransactionInfo updatedTransaction) async {
    try {
      if (updatedTransaction.id == null) {
        // Handle cases where the ID is missing
        throw ArgumentError('Transaction must have a valid ID.');
      }

      final updatedEntity = mapTransactionModelToEntity(updatedTransaction);
      await _box.putAt(updatedTransaction.id, updatedEntity);
    } catch (e) {
      log('TransactionRepositoryImpl::updateTransaction', error: e);

      // Handle any exceptions, such as HiveException or others, appropriately
      // Logging the error or returning a default value may be considered
      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  // Insert a single transaction into the database
  @override
  Future<void> insertTransaction(TransactionInfo newTransactionInfo) async {
    try {
      log('entered TransactionRepositoryImpl::insertTransaction');

      final existingTxn = _box.get(newTransactionInfo.id);

      log('entered TransactionRepositoryImpl::existingTxn ${existingTxn.toString()}');

      final newEntity = mapTransactionModelToEntity(newTransactionInfo);
      await _box.add(newEntity);
    } catch (e) {
      log('TransactionRepositoryImpl::insertTransaction', error: e);

      // Handle any exceptions, such as HiveException or others, appropriately
      // Logging the error or returning a default value may be considered
      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  // Delete a transaction from the database
  @override
  Future<void> deleteTransaction(TransactionInfo transactionToDelete) async {
    try {
      if (transactionToDelete.id == null) {
        // Handle cases where the ID is missing
        throw ArgumentError('Transaction must have a valid ID.');
      }
      await _box.delete(transactionToDelete.id);
    } catch (e) {
      log('TransactionRepositoryImpl::deleteTransaction', error: e);

      // Handle any exceptions, such as HiveException or others, appropriately
      // Logging the error or returning a default value may be considered
      rethrow; // Rethrow the exception for better error handling further up the call stack
    }
  }

  @override
  Future<void> deleteAllTransactions() async {
    await _box.clear();
  }
}
