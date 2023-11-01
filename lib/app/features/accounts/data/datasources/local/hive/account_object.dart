import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'account_object.g.dart';

part 'account_object.freezed.dart';

@freezed
abstract class AccountObject extends HiveObject with _$AccountObject {
  AccountObject._();

  @HiveType(typeId: 2)
  factory AccountObject({
    @HiveField(0) required int? id,
    @HiveField(1) required String? accountNumber,
    @HiveField(2) required String? accountName,
    @HiveField(3) required String? accountType,
    @HiveField(4) required double? accountBalance,
    @HiveField(5) required double? totalDebitAmount,
    @HiveField(6) required double? totalCreditAmount,
  }) = _AccountObject;
}
