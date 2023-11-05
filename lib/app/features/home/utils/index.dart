import 'package:sms_advanced/sms_advanced.dart';

bool isCreditTransaction(String sms) {
  final creditRegex = RegExp(r'credited.*? (\d+)');

  if (creditRegex.hasMatch(sms)) {
    final match = creditRegex.firstMatch(sms);
    if (match != null) {
      final amount = int.parse(match.group(1)!);
      if (amount > 0) {
        return true;
      }
    }
  }

  return false;
}

bool isDebitTransaction(String sms) {
  sms = sms.trim().replaceAll(RegExp(r'\n'), '\s');

  final debitRegex = RegExp(r'(debited|spent).*?(\d+)', caseSensitive: false);

  if (debitRegex.hasMatch(sms)) {
    final match = debitRegex.firstMatch(sms);
    if (match != null) {
      final amountString = match.group(2)!;
      if (amountString.isNotEmpty) {
        final amount = int.parse(amountString);
        if (amount > 0) {
          return true;
        }
      }
    }
  }

  return false;
}

String getWeekday(DateTime? date) {
  List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  if (date != null) return weekdays[date.weekday - 1];
  return "";
}

String formatTimeWithAMPM(DateTime? time) {
  if (time != null) {
    String hour =
        time.hour > 12 ? (time.hour - 12).toString() : time.hour.toString();
    String minute = time.minute.toString().padLeft(2, '0');
    String amPm = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $amPm';
  }
  return "";
}

double extractAmount(String smsBody) {
  final amountRegex = RegExp(r'(Rs|INR)\.?\s*(\d{1,3}(?:,?\d{3})*(?:\.\d{2})?)',
      caseSensitive: false);

  final match = amountRegex.firstMatch(smsBody);

  if (match != null) {
    final amountString = match.group(2)!.replaceAll(',', '');
    return double.parse(amountString);
  }

  final phrasesToCheck = ["spent", "debited with", "credited with"];

  for (final phrase in phrasesToCheck) {
    final phraseAmountRegex = RegExp(
        r'$phrase\s*(\d{1,3}(?:,?\d{3})*(?:\.\d{2})?)',
        caseSensitive: false);
    final phraseMatch = phraseAmountRegex.firstMatch(smsBody);

    if (phraseMatch != null) {
      final amountString = phraseMatch.group(1)!.replaceAll(',', '');
      return double.parse(amountString);
    }
  }

  return 0;
}

/// Filters the SMS messages to only include debit transactions.
List<SmsMessage> filterDebitTransactions(List<SmsMessage> smsMessages) {
  return smsMessages.where((sms) => isDebitTransaction(sms.body!)).toList();
}
