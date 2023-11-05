import 'package:expense_manager_x/app/features/home/presentation/providers/add_expense_provider.dart';
import 'package:expense_manager_x/app/features/home/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';

import 'package:expense_manager_x/app/shared/widgets/margin_xy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_form_dropdown.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/scrollable_column.dart';
import '../../../../shared/widgets/full_width_buttons.dart';
import '../../../accounts/presentation/providers/account_screen_provider.dart';

//TODO: remove that errorMessage soon you start editing the field, after getting a validation error!
final GlobalKey<FormState> _addExpenseFormKey = GlobalKey<FormState>();

class AddExpenseScreen extends ConsumerWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateNotifier = ref.watch(addExpenseScreenStateProvider.notifier);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Expense',
        onLeadingTap: () {},
        key: const Key('add_expense_mobile_appbar'),
      ),
      body: ScrollableColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AddAccountForm(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FullWidthElevatedTextButton(
              'save',
              onPressed: () async {
                if (_addExpenseFormKey.currentState!.validate()) {
                  _addExpenseFormKey.currentState!.save();

                  await stateNotifier.saveExpense();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('transaction saved successfully.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    _addExpenseFormKey.currentState!.reset();
                    // Navigator.of(context).pop(true);
                  }
                }
              },
            ),
          ),
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
    final stateNotifier = ref.read(addExpenseScreenStateProvider.notifier);
    final theme = Theme.of(context);

    return Form(
      key: _addExpenseFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MarginY(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MarginY(16),
                Text(
                  'add your expense, choose category and more.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.45),
                  ),
                ),
              ],
            ),
          ),
          const MarginY(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextFormField(
              hintText: 'amount',
              label: 'amount',
              keyboardType: TextInputType.number,
              onChanged: (String? value) =>
                  stateNotifier.setExpenseAmount(value),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "you gotta enter some amount to proceed.";
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
              hintText: 'what was it for?',
              label: 'what was it for?',
              keyboardType: TextInputType.text,
              onChanged: (String? value) =>
                  stateNotifier.setExpenseTitle(value),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "you can enter a little description here";
                } else {
                  return null;
                }
              },
            ),
          ),
          const MarginY(16),
          const MarginY(8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: AddExpenseSourceDropdown(),
          ),
          const MarginY(32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: AddExpenseCategories(),
          ),
          const MarginY(32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ExpenseType(),
          ),
          const MarginY(16),
        ],
      ),
    );
  }
}

class ExpenseType extends ConsumerWidget {
  const ExpenseType({super.key});

  static const expenseTypes = ["Debit", "Credit"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addExpenseScreenStateProvider);
    final stateNotifier = ref.read(addExpenseScreenStateProvider.notifier);
    final theme = Theme.of(context);

    buildCategoryPills() {
      List<Widget> pills = [];
      for (final expenseType in expenseTypes) {
        pills.add(
          Pill(
            label: expenseType,
            backgroundColor: state.expenseType == expenseType
                ? Colors.indigo.withOpacity(0.75)
                : Colors.grey.withOpacity(0.2),
            onTap: () => stateNotifier.setExpenseType(expenseType),
          ),
        );
      }
      return pills;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select a transaction type.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.45),
          ),
        ),
        const MarginY(16),
        Wrap(
          runSpacing: 8,
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          children: buildCategoryPills(),
        ),
      ],
    );
  }
}

class AddExpenseCategories extends ConsumerWidget {
  const AddExpenseCategories({super.key});

  static const categories = ["Shopping", "Entertainment", "Bills", "Others"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addExpenseScreenStateProvider);
    final stateNotifier = ref.read(addExpenseScreenStateProvider.notifier);
    final theme = Theme.of(context);

    buildCategoryPills() {
      List<Widget> pills = [];
      for (final category in categories) {
        pills.add(
          Pill(
            label: category,
            backgroundColor: state.expenseCategory == category
                ? Colors.indigo.withOpacity(0.75)
                : Colors.grey.withOpacity(0.2),
            onTap: () => stateNotifier.setExpenseCategory(category),
          ),
        );
      }
      return pills;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select a category.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.45),
          ),
        ),
        const MarginY(16),
        Wrap(
          runSpacing: 8,
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          children: buildCategoryPills(),
        ),
      ],
    );
  }
}

class AddExpenseSourceDropdown extends ConsumerWidget {
  const AddExpenseSourceDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addExpenseScreenStateProvider);
    final accountListAsync = ref.watch(accountListProvider);
    final stateNotifier = ref.read(addExpenseScreenStateProvider.notifier);

    List<String>? accountList = accountListAsync.hasValue
        ? accountListAsync
            .whenData((value) => value
                .map((e) => "${e.maskedAccountNumber} - ${e.accountName}")
                .toList())
            .value
        : [];

    return CustomFormDropdown<String>(
      validator: (String? value) {
        return null;
      },
      selectedValue: state.expenseSourceAccount,
      hintText: 'source account',
      onChanged: (String? value) =>
          stateNotifier.setExpenseSourceAccount(value),
      items: accountList!,
    );
  }
}

class Pill extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function()? onTap;

  const Pill({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withOpacity(0.75),
          ),
        ),
      ),
    );
  }
}
