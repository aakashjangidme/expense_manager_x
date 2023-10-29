import 'package:expense_manager_x/app/features/home/presentation/providers/sms_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/transaction_provider.dart';
import '../widgets/custom_heading.dart';
import '../widgets/month_selector.dart';
import '../widgets/total_balance_widget.dart';
import '../widgets/txn_list_builder.dart';
import '../widgets/welcome_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionStatus = ref.watch(sMSPermissionStatusProvider);

    if (permissionStatus.isRestricted) {
      _requestPermission(ref);
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        onLeadingTap: () {},
        key: const Key('accounts_mobile_appbar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      key: const Key('accounts_mobile'),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.refresh(transactionListFromSMSIsolateProvider.future),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            MultiSliver(
              pushPinnedChildren: true,
              children: [
                const SizedBox(height: 16.0),
                const WelcomeWidget(),
                const SizedBox(height: 16.0),
                const TotalBalanceWidget(),
                // SizedBox(height: 16.0),
                buildSliverPinnedHeader(context),
                const TransactionListBuilder()
              ],
            )
          ],
        ),
      ),
    );
  }

/*  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SizedBox(height: 16.0),
  WelcomeWidget(),
  SizedBox(height: 16.0),
  TotalBalanceWidget(),
  SizedBox(height: 16.0),
  CustomHeading('Transactions'),
  SizedBox(height: 16.0),
  MonthSelectorAndTotalDebit(),
  SizedBox(height: 16.0),
  Flexible(child: TransactionListBuilder(),),
  ],
  ),*/

  SliverPinnedHeader buildSliverPinnedHeader(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        alignment: Alignment.bottomCenter,
        color: Theme.of(context).colorScheme.surface,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            CustomHeading('Transactions'),
            // SizedBox(height: 8.0),
            MonthSelectorAndTotalDebit(),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  void _requestPermission(WidgetRef ref) async {
    final status = await Permission.sms.request();
    ref
        .read(sMSPermissionStatusProvider.notifier)
        .updatePermissionStatus(status);
  }
}
