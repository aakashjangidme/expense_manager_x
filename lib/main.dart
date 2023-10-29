import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/expense_manager_app.dart';
import 'app/features/home/data/datasources/local/hive/transaction.dart';
import 'app/features/home/data/datasources/local/hive/txn_type_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseHive();
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: ExpenseManagerApp(),
    ),
  );
}

Future<void> initialiseHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionImplAdapter());
  Hive.registerAdapter(TxnTypeAdapter());
  await Hive.openBox<Transaction>('transactions');
}
