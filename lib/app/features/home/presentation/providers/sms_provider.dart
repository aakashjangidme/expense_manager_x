import 'dart:async';
import 'dart:developer';

import 'package:expense_manager_x/app/features/home/domain/providers/txn_repository_provider.dart';
import 'package:expense_manager_x/app/features/home/utils/extract_txn_info.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sms_advanced/sms_advanced.dart';

import '../../domain/models/transaction_info.dart';

part 'sms_provider.g.dart';

/// Fetches all SMS messages from the device.
@pragma('vm:entry-point')
Future<List<SmsMessage>> fetchSMSMessages(dynamic arg) async {
  return await SmsQuery().querySms(kinds: [SmsQueryKind.Inbox]);
}

Future<List<SmsMessage>> fetchSMSMessagesInBackground() async {
  log('fetchSMSMessagesInBackground');
  return await flutterCompute(fetchSMSMessages, 1);
}

@riverpod
Future<List<TransactionInfo>> transactionListFromSMSIsolate(
    TransactionListFromSMSIsolateRef ref) async {
  List<TransactionInfo> txnInfoList = [];
  try {
    log('entering transactionListFromSMSIsolate...');

    final txnRepo = ref.watch(transactionRepositoryProvider);

    // If not, fetch SMS messages on a background isolate
    final List<SmsMessage> smsList = await fetchSMSMessages(null);
    log('transactionListFromSMSIsolate::smsList.length ${smsList.length}');

    txnInfoList = smsList.map(extractTransactionalInfo).toList();

    log('transactionListFromSMSIsolate::txnInfoList.length ${txnInfoList.length}');

    await txnRepo.insertAllTransactions(txnInfoList);

    log('transactionListFromSMSIsolate::txnList.length ${txnInfoList.length}');
  } catch (error, stack) {
    log('transactionListFromSMSIsolate::error',
        error: error, stackTrace: stack);
  }

  return txnInfoList;
}
