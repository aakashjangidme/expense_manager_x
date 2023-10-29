import '../models/transaction_info.dart';

abstract class TransactionRepository {
  // Retrieve all transactions from the cache
  Future<List<TransactionInfo>> getAllTransactions();

  TransactionInfo? getTransactionById(TransactionInfo transactionInfo);

  Future<void> insertAllTransactions(List<TransactionInfo> transactionInfoList);

  Future<void> updateTransaction(TransactionInfo transactionInfo);

  Future<void> insertTransaction(TransactionInfo transactionInfo);

  Future<void> deleteTransaction(TransactionInfo transactionInfo);

  Future<void> deleteAllTransactions();
}
