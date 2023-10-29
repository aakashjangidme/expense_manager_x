import 'package:hive/hive.dart';

import '../../../../../../core/configs/constants.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? transactionTitle;
  @HiveField(2)
  TxnType? txnType;
  @HiveField(3)
  String? transactionSource;
  @HiveField(4)
  DateTime? transactionDate;
  @HiveField(5)
  double? transactionAmount;
  @HiveField(6)
  String? transactionCategory;
  @HiveField(7)
  String? txnBody;

  Transaction(
      {this.id,
        this.transactionTitle,
        this.transactionCategory,
        this.txnType,
        this.transactionSource,
        this.transactionDate,
        this.transactionAmount,
        this.txnBody});
}
