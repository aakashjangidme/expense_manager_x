import 'dart:developer';

import 'package:expense_manager_x/app/shared/widgets/margin_xy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/scrollable_column.dart';
import '../providers/add_account_provider.dart';
import '../widgets/add_account_type_dropdown.dart';
import '../../../../shared/widgets/full_width_buttons.dart';

//TODO: remove that errorMessage soon you start editing the field, after getting a validation error!
final GlobalKey<FormState> _addAccountFormKey = GlobalKey<FormState>();

class AddAccountScreen extends ConsumerWidget {
  const AddAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Account',
        onLeadingTap: () {},
        key: const Key('add_account_mobile_appbar'),
      ),
      body: ScrollableColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AddAccountForm(),
          const Spacer(),
          const SaveButton(),
          const MarginY(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FullWidthTextButton(
              'cancel',
              onPressed: () => context.pop(),
            ),
          ),
          const MarginY(16)
        ],
      ),
    );
  }
}

class AddAccountForm extends ConsumerWidget {
  const AddAccountForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateNotifier = ref.read(addAccountsScreenStateProvider.notifier);
    final theme = Theme.of(context);

    return Form(
      key: _addAccountFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MarginY(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'enter your details to continue.',
                  style: theme.textTheme.headlineMedium,
                ),
                const MarginY(16),
                Text(
                  'don\'t worry, it is stored with encryption.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.45),
                  ),
                ),
              ],
            ),
          ),
          const MarginY(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextFormField(
              hintText: 'account number',
              label: 'account number',
              keyboardType: TextInputType.number,
              onChanged: (String? accountNumber) =>
                  stateNotifier.setAccountNumber(accountNumber),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "please enter a valid account number.";
                } else {
                  return null;
                }
              },
            ),
          ),
          const MarginY(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextFormField(
              hintText: 'account name',
              label: 'account name',
              keyboardType: TextInputType.text,
              onChanged: (String? accountName) =>
                  stateNotifier.setAccountName(accountName),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "please enter a valid account name.";
                } else {
                  return null;
                }
              },
            ),
          ),
          const MarginY(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              hintText: 'account balance',
              label: 'account balance',
              keyboardType: TextInputType.number,
              onChanged: (String? accountBalance) =>
                  stateNotifier.setAccountBalance(accountBalance),
            ),
          ),
          const MarginY(16),
          const MarginY(8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: AccountTypeDropDown(),
          ),
          const MarginY(16),
        ],
      ),
    );
  }
}

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateNotifier = ref.read(addAccountsScreenStateProvider.notifier);
    final isLoading = ref.watch(
        addAccountsScreenStateProvider.select((value) => value.isLoading));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FullWidthElevatedTextButton(
        'save',
        loading: isLoading,
        onPressed: () async {
          if (_addAccountFormKey.currentState!.validate()) {
            _addAccountFormKey.currentState!.save();

            await stateNotifier.saveAccount();

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('account saved successfully.'),
                  duration: Duration(seconds: 2),
                ),
              );
              _addAccountFormKey.currentState!.reset();
            }
          }
        },
      ),
    );
  }
}
