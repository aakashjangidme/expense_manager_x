import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../../../../../core/configs/constants.dart';

part 'transaction.g.dart';

part 'transaction.freezed.dart';

@freezed
abstract class Transaction extends HiveObject with _$Transaction {
  Transaction._();

  @HiveType(typeId: 0)
  factory Transaction({
    @HiveField(0) required int? id,
    @HiveField(1) required String? transactionTitle,
    @HiveField(2) required TxnType? txnType,
    @HiveField(3) required String? transactionSource,
    @HiveField(4) required DateTime? transactionDate,
    @HiveField(5) required double? transactionAmount,
    @HiveField(6) required String? transactionCategory,
    @HiveField(7) required String? txnBody,
  }) = _Transaction;
}
