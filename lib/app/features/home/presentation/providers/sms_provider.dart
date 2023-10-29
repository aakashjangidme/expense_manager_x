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

/// Fetches all SMS messages from the device in a background isolate.
Future<List<SmsMessage>> fetchSMSMessagesInBackground() async {
  log('fetchSMSMessagesInBackground');
  return await flutterCompute(fetchSMSMessages, 1);
}

@riverpod
Future<List<TransactionInfo>> transactionListFromSMSIsolate(
    TransactionListFromSMSIsolateRef ref) async {
  final transactionRepository = ref.watch(transactionRepositoryProvider);
  final cachedTransactions = await transactionRepository.getAllTransactions();
  final smsMessages = await fetchSMSMessages(1);

  final newTransactions = smsMessages
      .map(extractTransactionalInfo)
      .where((txn) => !transactionExistsInCache(txn.id, cachedTransactions))
      .toList();

  // await transactionRepository.deleteAllTransactions();

  await transactionRepository.insertAllTransactions(newTransactions);

  return await transactionRepository.getAllTransactions();
}

bool transactionExistsInCache(
    int txnId, List<TransactionInfo> cachedTransactions) {
  return cachedTransactions.any((txn) => txn.id == txnId);
}

/*
@riverpod
Future<List<TransactionInfo>> transactionListFromSMSIsolate(
    TransactionListFromSMSIsolateRef ref) async {
  List<TransactionInfo> finalTxnInfoList = [];
  try {
    log('entering transactionListFromSMSIsolate...');


    final transactionRepository = ref.watch(transactionRepositoryProvider);
    final cachedTransactions = await transactionRepository.getAllTransactions();
    final List<SmsMessage> smsMessages  = await _fetchSMSMessages(null);

    log('transactionListFromSMSIsolate::smsMessages .length ${smsMessages .length}');

    final txnInfoListExtractedFromSMS =
    smsMessages.map(extractTransactionalInfo).toList();


    final newTransactions = smsMessages
        .map(extractTransactionalInfo)
        .where((txn) => !transactionExistsInCache(txn.id, cachedTransactions))
        .toList();

    log('transactionListFromSMSIsolate::txnInfoListExtractedFromSMS.length ${txnInfoListExtractedFromSMS.length}');

    log('transactionListFromSMSIsolate::txnInfoListFromCache.length ${txnInfoListFromCache.length}');

    for (var txn in txnInfoListExtractedFromSMS) {
      if (!transactionExistsInCache(txn.id, txnInfoListFromCache)) {
        await txnRepo.insertTransaction(txn);
      }
    }

    final finalTxnInfoList = await txnRepo.getAllTransactions();

    log('transactionListFromSMSIsolate::finalTxnInfoList.length ${finalTxnInfoList.length}');
  } catch (error, stack) {
    log('transactionListFromSMSIsolate::error',
        error: error, stackTrace: stack);
  }

  return finalTxnInfoList;
}
*/
