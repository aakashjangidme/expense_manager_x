import '../../../../core/configs/constants.dart';
import '../../data/datasources/local/hive/transaction.dart';
import '../models/transaction_info.dart';

TransactionInfo transformToTransactionInfo(Transaction entity) {
  return TransactionInfo(
    id: entity.id,
    transactionTitle: entity.transactionTitle,
    txnType: entity.txnType ?? TxnType.unknown,
    transactionSource: entity.transactionSource,
    transactionDate: entity.transactionDate ?? DateTime.now(),
    transactionAmount: entity.transactionAmount,
    transactionCategory: entity.transactionCategory,
    txnBody: entity.txnBody,
    key: entity.key,
    isDismissed: entity.isDismissed,
  );
}

Transaction transformToTransactionObject(TransactionInfo model) {
  return Transaction(
    id: model.id,
    transactionTitle: model.transactionTitle,
    txnType: model.txnType ?? TxnType.unknown,
    transactionSource: model.transactionSource,
    transactionDate: model.transactionDate ?? DateTime.now(),
    transactionAmount: model.transactionAmount,
    transactionCategory: model.transactionCategory,
    txnBody: model.txnBody,
    isDismissed: model.isDismissed,
  );
}
