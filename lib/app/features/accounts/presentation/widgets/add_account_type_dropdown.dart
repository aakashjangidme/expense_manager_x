import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/add_account_provider.dart';

List<String> accountTypes = [
  "Bank",
  "Credit Card",
  "Prepaid Card",
  "Debit Card"
];

class AccountTypeDropDown extends ConsumerWidget {
  const AccountTypeDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addAccountsScreenStateProvider);
    final stateNotifier = ref.read(addAccountsScreenStateProvider.notifier);
    final theme = Theme.of(context);

    return DropdownButtonFormField(
      validator: (String? value) {
        if (value == null) {
          return "please enter a valid account type.";
        } else {
          return null;
        }
      },
      value: state.accountType,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(1),
      ),
      elevation: 2,
      hint: Text(
        'account type',
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(1),
        ),
      ),
      // underline: const SizedBox(),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: accountTypes.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? accountType) =>
          stateNotifier.setAccountType(accountType),
    );
  }
}
