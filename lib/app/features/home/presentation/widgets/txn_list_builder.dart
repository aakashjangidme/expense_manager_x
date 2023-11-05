import 'dart:developer';

import 'package:expense_manager_x/app/features/home/presentation/widgets/update_txn_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/configs/constants.dart';
import '../../domain/models/transaction_info.dart';
import '../providers/transaction_provider.dart';

class TransactionListBuilder extends ConsumerWidget {
  const TransactionListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTransactions = ref.watch(filteredTransactionsProvider);

    return filteredTransactions.when(
      data: (item) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: item.length,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        itemBuilder: (context, index) {
          TransactionInfo txnInfo = item[index];
          bool isDebit = txnInfo.txnType == TxnType.debit;

          return Dismissible(
            background: Container(color: Colors.redAccent),
            key: ValueKey(txnInfo.key),
            onDismissed: (direction) async {
              item.removeWhere((element) => element.id == txnInfo.id);
              await ref
                  .read(debitTransactionsProvider.notifier)
                  .markTransactionAsDismissed(txnInfo);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${txnInfo.transactionTitle} dismissed'),
                  ),
                );
              }
            },
            child: ListTile(
              iconColor: Colors.greenAccent,
              onTap: () => _showUpdateTransactionOverlay(context, txnInfo, ref),
              onLongPress: () {
                log(txnInfo.txnBody.toString());
              },
              leading: const Icon(
                Icons.shopping_bag_outlined,
              ),
              subtitle: Wrap(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  if (txnInfo.transactionSource != null &&
                      txnInfo.transactionSource!.trim().isNotEmpty) ...[
                    Text(txnInfo.transactionSource.toString(),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(width: 8.0),
                  ],
                  Text(txnInfo.getFormattedDate)
                ],
              ),
              title: Row(
                children: [Text(txnInfo.transactionTitle.toString())],
              ),
              trailing: Text(
                ('\u{20B9}') +
                    (isDebit ? ' -' : ' +') +
                    (txnInfo.transactionAmount.toString()),
                style: TextStyle(color: isDebit ? Colors.red : Colors.green),
              ),
            ),
          );
        },
      ),
      error: (e, st) {
        log('TransactionListBuilder', error: e.toString(), stackTrace: st);

        return Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              e.toString(),
            ),
          ),
        );
      },
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*return isLoading
        ? Container(
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredTransactions?.length,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom),
            itemBuilder: (context, index) {
              TransactionInfo txnInfo = filteredTransactions[index];
              bool isDebit = txnInfo.txnType == TxnType.debit;

              return ListTile(
                onTap: () =>
                    _showUpdateTransactionOverlay(context, txnInfo, ref),
                onLongPress: () {
                  log(txnInfo.txnBody);
                },
                leading: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.lightGreenAccent,
                ),
                subtitle: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(txnInfo.transactionSource,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(width: 8.0),
                    Text(txnInfo.getFormattedDate)
                  ],
                ),
                title: Row(
                  children: [Text(txnInfo.transactionTitle)],
                ),
                trailing: Text(
                  ('\u{20B9}') +
                      (isDebit ? ' -' : ' +') +
                      (txnInfo.transactionAmount.toStringAsFixed(2)),
                  style: TextStyle(color: isDebit ? Colors.red : Colors.green),
                ),
              );
            },
          );*/
  }
}

void _showUpdateTransactionOverlay(
    BuildContext context, TransactionInfo txnInfo, WidgetRef ref) async {
  // final smsProviderNotifier = ref.read.notifier);

  await showDialog(
    context: context,
    builder: (context) => UpdateTransactionOverlay(
      txnId: txnInfo.id!,
    ),
  );
}
