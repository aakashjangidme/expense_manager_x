// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalDebitsHash() => r'31df0403dd03c81893aebdafeb2a03e4f2aab68b';

/// See also [totalDebits].
@ProviderFor(totalDebits)
final totalDebitsProvider = AutoDisposeProvider<double>.internal(
  totalDebits,
  name: r'totalDebitsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalDebitsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalDebitsRef = AutoDisposeProviderRef<double>;
String _$uniqueMonthsHash() => r'04121142c30a59b620004bbb54a6cf1f6b175332';

/// See also [uniqueMonths].
@ProviderFor(uniqueMonths)
final uniqueMonthsProvider = AutoDisposeProvider<List<String>>.internal(
  uniqueMonths,
  name: r'uniqueMonthsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$uniqueMonthsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UniqueMonthsRef = AutoDisposeProviderRef<List<String>>;
String _$sMSPermissionStatusHash() =>
    r'497635bb94aacbf5f713c1463d04f30bfef4f652';

/// See also [SMSPermissionStatus].
@ProviderFor(SMSPermissionStatus)
final sMSPermissionStatusProvider =
    AutoDisposeNotifierProvider<SMSPermissionStatus, PermissionStatus>.internal(
  SMSPermissionStatus.new,
  name: r'sMSPermissionStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sMSPermissionStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SMSPermissionStatus = AutoDisposeNotifier<PermissionStatus>;
String _$filteredTransactionsHash() =>
    r'e87e154c3aa4a2ccdcabcc717146d14f5f3a19d1';

/// See also [FilteredTransactions].
@ProviderFor(FilteredTransactions)
final filteredTransactionsProvider = AutoDisposeAsyncNotifierProvider<
    FilteredTransactions, List<TransactionInfo>>.internal(
  FilteredTransactions.new,
  name: r'filteredTransactionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredTransactionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilteredTransactions
    = AutoDisposeAsyncNotifier<List<TransactionInfo>>;
String _$selectedMonthHash() => r'b2a0586523cef22ba68745f05a6c292e57f8bfc2';

/// See also [SelectedMonth].
@ProviderFor(SelectedMonth)
final selectedMonthProvider =
    AutoDisposeNotifierProvider<SelectedMonth, String>.internal(
  SelectedMonth.new,
  name: r'selectedMonthProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedMonthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedMonth = AutoDisposeNotifier<String>;
String _$debitTransactionsHash() => r'6ae38fcd4a774bd8f16a1e792e87075b26a6a198';

/// See also [DebitTransactions].
@ProviderFor(DebitTransactions)
final debitTransactionsProvider = AutoDisposeNotifierProvider<DebitTransactions,
    List<TransactionInfo>>.internal(
  DebitTransactions.new,
  name: r'debitTransactionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debitTransactionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DebitTransactions = AutoDisposeNotifier<List<TransactionInfo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
