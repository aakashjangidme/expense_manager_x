import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.g.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  Account._();

  factory Account({
    required int? id,
    required String? accountNumber,
    required String? accountName,
    required String? accountType,
    required double? accountBalance,
    required double? totalDebitAmount,
    required double? totalCreditAmount,
    required dynamic key,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  String get maskedAccountNumber {
    if (accountNumber != null && accountNumber!.length >= 4) {
      final maskedPart = 'X' * (accountNumber!.length - 4);
      final last4Digits = accountNumber!.substring(accountNumber!.length - 4);
      return '$maskedPart $last4Digits';
    } else {
      return accountNumber ?? '';
    }
  }
}
