import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/animated_text_switcher_for_currency.dart';
import '../providers/transaction_provider.dart';
import 'month_selector_widget.dart';

class MonthSelectorAndTotalDebit extends ConsumerWidget {
  const MonthSelectorAndTotalDebit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalDebits = ref.watch(totalDebitsProvider).toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          const MonthSelectorWidget(),
          Row(
            children: [
              AnimatedTextSwitcherForCurrency(
                double.tryParse(totalDebits)!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.red),
              ),
              const SizedBox(width: 4.0),
            ],
          ),
        ],
      ),
    );
  }
}
