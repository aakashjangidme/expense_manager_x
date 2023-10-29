import 'package:sms_advanced/sms_advanced.dart';

import '../../../core/configs/constants.dart';
import '../domain/models/transaction_info.dart';
import 'index.dart';

TransactionInfo extractTransactionalInfo(SmsMessage message) {
  String transactionTitle = "Unknown";
  TxnType txnType = TxnType.unknown;
  String? transactionSource = message.address;
  DateTime? transactionDate = message.date;

  double transactionAmount = 0;
  String transactionCategory = "Unknown";

  String smsBody = message.body!;
  smsBody = smsBody.trim().replaceAll(RegExp(r'\n'), '\s').toUpperCase();

  if (isCreditTransaction(smsBody)) {
    txnType = TxnType.credit;
  } else if (isDebitTransaction(smsBody)) {
    txnType = TxnType.debit;
  }

  transactionAmount = extractAmount(smsBody);
  transactionSource = extractTransactionSource(smsBody);
  transactionTitle = extractTransactionTitle(smsBody);

  return TransactionInfo(
    id: message.id!,
    transactionTitle: transactionTitle,
    txnType: txnType,
    transactionSource: transactionSource ?? "",
    transactionDate: transactionDate!,
    transactionAmount: transactionAmount,
    transactionCategory: transactionCategory,
    txnBody: smsBody,
    key: null,
    isDismissed: false,
  );
}

String extractTransactionSource(String smsBody) {
  final bankKeywords = {
    "HDFC": ["BANK", "UPI", "CARD", ""],
    "KOTAK": ["BANK", "CARD", ""],
    "SBI": ["BANK", "CARD", ""],
    "JPB": ["BANK", "UPI", "CARD", ""],
    "AXIS": ["BANK", "UPI", "CARD", ""],
    // Add more bank keywords and transaction methods as needed
  };

  for (final bank in bankKeywords.keys) {
    for (final method in bankKeywords[bank]!) {
      final keyword = "$bank $method";
      if (smsBody.contains(keyword)) {
        final startIdx = smsBody.indexOf(keyword);
        final endIdx = smsBody.indexOf(" ", startIdx + keyword.length);
        if (endIdx != -1) {
          final source = smsBody.substring(startIdx, endIdx);
          return source;
        }
      }
    }
  }

  return "Unknown";
}

String extractTransactionTitle(String smsBody) {
  final keywords = [
    "TO VPA",
    "WITHDRAWN",
    "PURCHASED",
    "TO"
  ]; // Add more transaction keywords

  for (final keyword in keywords) {
    if (smsBody.contains(keyword)) {
      final startIdx = smsBody.indexOf(keyword) + keyword.length;
      final endIdx = smsBody.indexOf("(", startIdx);
      if (endIdx != -1) {
        final title = smsBody.substring(startIdx, endIdx).trim();
        return title;
      }
    }
  }

  return "Unknown";
}
