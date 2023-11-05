import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/custom_form_dropdown.dart';
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

    return CustomFormDropdown<String>(
      validator: (String? value) {
        if (value == null) {
          return "please enter a valid account type.";
        } else {
          return null;
        }
      },
      selectedValue: state.accountType,
      hintText: 'account type',
      onChanged: (String? accountType) =>
          stateNotifier.setAccountType(accountType),
      items: accountTypes,
    );
  }
}
