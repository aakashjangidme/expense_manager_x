import '../../../../core/configs/constants.dart';
import '../../data/datasources/local/hive/transaction.dart';
import '../models/transaction_info.dart';

TransactionInfo transformToTransactionInfo(Transaction entity) {
  return TransactionInfo(
    id: entity.id ?? 0,
    // Provide a default value for null id
    transactionTitle: entity.transactionTitle ?? "",
    txnType: entity.txnType ?? TxnType.unknown,
    // Provide a default value for null txnType
    transactionSource: entity.transactionSource ?? "",
    transactionDate: entity.transactionDate ?? DateTime.now(),
    // Provide a default value for null date
    transactionAmount: entity.transactionAmount ?? 0.0,
    // Provide a default value for null amount
    transactionCategory: entity.transactionCategory ?? "",
    txnBody: entity.txnBody ?? "",
    key: entity.key,
    isDismissed: entity.isDismissed,
  );
}

Transaction transformToTransactionObject(TransactionInfo model) {
  return Transaction(
    id: model.id ?? 0,
    // Provide a default value for null id
    transactionTitle: model.transactionTitle ?? "",
    txnType: model.txnType ?? TxnType.unknown,
    // Provide a default value for null txnType
    transactionSource: model.transactionSource ?? "",
    transactionDate: model.transactionDate ?? DateTime.now(),
    // Provide a default value for null date
    transactionAmount: model.transactionAmount ?? 0.0,
    // Provide a default value for null amount
    transactionCategory: model.transactionCategory ?? "",
    txnBody: model.txnBody ?? "",
    isDismissed: model.isDismissed,
  );
}
