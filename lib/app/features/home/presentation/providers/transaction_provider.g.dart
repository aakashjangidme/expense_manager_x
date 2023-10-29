// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalDebitsHash() => r'50038e1f54df19cd318fe1170639a0f3d876a20f';

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
    r'500956ac1a62b43ee366b4e9ffb4cf87f17549d9';

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
String _$debitTransactionsHash() => r'9431b894b9e377542643468d244f192786662162';

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
