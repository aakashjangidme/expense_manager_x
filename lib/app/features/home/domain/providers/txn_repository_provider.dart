import 'dart:developer';

import 'package:expense_manager_x/app/features/home/data/repositories/transaction_repository_impl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/local/hive/transaction.dart';
import '../repositories/transaction_repository.dart';

part 'txn_repository_provider.g.dart';

@riverpod
Box<Transaction> transactionAdapter(TransactionAdapterRef ref) {
  return Hive.box<Transaction>('transactions');
}

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  final datasource = ref.watch(transactionAdapterProvider);
  log('datasource.isEmpty ${datasource.isEmpty}');
  return TransactionRepositoryImpl(box: datasource);
}
