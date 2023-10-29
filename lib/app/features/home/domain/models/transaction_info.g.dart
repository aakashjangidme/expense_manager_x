// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionInfoImpl _$$TransactionInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionInfoImpl(
      id: json['id'] as int,
      transactionTitle: json['transactionTitle'] as String,
      txnType: $enumDecode(_$TxnTypeEnumMap, json['txnType']),
      transactionSource: json['transactionSource'] as String,
      transactionDate: DateTime.parse(json['transactionDate'] as String),
      transactionAmount: (json['transactionAmount'] as num).toDouble(),
      transactionCategory: json['transactionCategory'] as String,
      txnBody: json['txnBody'] as String,
    );

Map<String, dynamic> _$$TransactionInfoImplToJson(
        _$TransactionInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionTitle': instance.transactionTitle,
      'txnType': _$TxnTypeEnumMap[instance.txnType]!,
      'transactionSource': instance.transactionSource,
      'transactionDate': instance.transactionDate.toIso8601String(),
      'transactionAmount': instance.transactionAmount,
      'transactionCategory': instance.transactionCategory,
      'txnBody': instance.txnBody,
    };

const _$TxnTypeEnumMap = {
  TxnType.debit: 'debit',
  TxnType.credit: 'credit',
  TxnType.unknown: 'unknown',
};
