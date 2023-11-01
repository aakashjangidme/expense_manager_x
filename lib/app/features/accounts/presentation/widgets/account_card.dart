import 'dart:developer';

import 'package:expense_manager_x/app/features/accounts/presentation/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/animated_text_switcher_for_currency.dart';
import '../../../../shared/widgets/display_error_message.dart';
import '../../domain/models/account.dart';

class AccountCard extends ConsumerWidget {
  const AccountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAccountList = ref.watch(accountListProvider);

    return asyncAccountList.when(
      data: (accountList) => ListView.builder(
        itemCount: accountList.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Account account = accountList[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              account.accountName.toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              account.maskedAccountNumber.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        AnimatedTextSwitcherForCurrency(
                          account.accountBalance ?? 0,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total (Oct \'23)'),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Transform.translate(
                                  offset: const Offset(-8, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        'Credits',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                if (account.totalCreditAmount == null)
                                  Text(
                                    'NA',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  )
                                else
                                  AnimatedTextSwitcherForCurrency(
                                    account.totalCreditAmount!,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.translate(
                                  offset: const Offset(-8, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.arrow_drop_up_outlined,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        'Expense',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                if (account.totalDebitAmount == null)
                                  Text(
                                    'NA',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  )
                                else
                                  AnimatedTextSwitcherForCurrency(
                                    account.totalDebitAmount!.toDouble(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          );
        },
      ),
      error: (error, st) => DisplayErrorMessage(
        errorMessage: error.toString(),
        st: st,
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
