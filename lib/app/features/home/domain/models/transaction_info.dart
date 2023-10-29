import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/configs/constants.dart';
import '../../utils/index.dart';

part 'transaction_info.freezed.dart';
part 'transaction_info.g.dart';

@freezed
class TransactionInfo with _$TransactionInfo {
  const TransactionInfo._();

  const factory TransactionInfo({
    required int id,
    required String transactionTitle,
    required TxnType txnType,
    required String transactionSource,
    required DateTime transactionDate,
    required double transactionAmount,
    required String transactionCategory,
    required String txnBody,
  }) = _TransactionInfo;

  /*
  final int id;
  final String transactionTitle;
  final TxnType txnType;
  final String transactionSource;
  final DateTime transactionDate;
  final double transactionAmount;
  final String transactionCategory;
  final String txnBody;
  */

  // TxnType get txnType => txnType == 'open' ? Status.open : Status.closed;

  String get getFormattedDate =>
      "${transactionDate.day} ${getWeekday(transactionDate)} • ${formatTimeWithAMPM(transactionDate)}";

  factory TransactionInfo.fromJson(Map<String, dynamic> json) =>
      _$TransactionInfoFromJson(json);
}
