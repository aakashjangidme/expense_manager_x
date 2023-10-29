import '../models/transaction_info.dart';

abstract class TransactionRepository {
  // Retrieve all transactions from the cache
  Future<List<TransactionInfo>> getAllTransactions();
  Future<void> insertAllTransactions(List<TransactionInfo> txnInfoList);
  Future<void> updateTransaction(TransactionInfo updatedTransaction);
  Future<void> insertTransaction(TransactionInfo newTransactionInfo) ;
  Future<void> deleteTransaction(TransactionInfo newTransactionInfo) ;
}
