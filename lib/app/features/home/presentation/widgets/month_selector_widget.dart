import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/transaction_provider.dart';


class MonthSelectorWidget extends ConsumerWidget {
  const MonthSelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uniqueMonths = ref.watch(uniqueMonthsProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);

    return DropdownButton<String>(
      elevation: 1,
      underline: SizedBox.fromSize(),
      value: selectedMonth,
      onChanged: (String? newValue) {
        ref.read(selectedMonthProvider.notifier).setSelectedMonth(newValue!);
      },
      items: uniqueMonths.map((String month) {
        return DropdownMenuItem<String>(
          value: month,
          child: Text(month),
        );
      }).toList(),
    );
  }
}
