import 'package:expense_manager_x/app/core/router/routes.dart';
import 'package:expense_manager_x/app/features/accounts/presentation/widgets/account_card.dart';
import 'package:expense_manager_x/app/shared/widgets/margin_xy.dart';
import 'package:expense_manager_x/app/shared/widgets/scrollable_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/account_screen_provider.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Accounts',
        onLeadingTap: () {},
        key: const Key('accounts_mobile_appbar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.push("${Routes.accounts}/${Routes.addAccount}"),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(accountListProvider.future),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarginY(16),
            _buildAccountsScreenHeader(theme),
            const MarginY(16),
            const Flexible(child: AccountCard()),
          ],
        ),
      ),
    );
  }

  Padding _buildAccountsScreenHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'here you can add, update, view & analyse your accounts.',
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.textTheme.titleMedium?.color?.withOpacity(0.75),
        ),
      ),
    );
  }
}
