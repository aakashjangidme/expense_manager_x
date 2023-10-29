// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'txn_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionAdapterHash() =>
    r'7bd068109c89f35418305904d66de4ecbd4c012a';

/// See also [transactionAdapter].
@ProviderFor(transactionAdapter)
final transactionAdapterProvider =
    AutoDisposeProvider<Box<Transaction>>.internal(
  transactionAdapter,
  name: r'transactionAdapterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionAdapterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionAdapterRef = AutoDisposeProviderRef<Box<Transaction>>;
String _$transactionRepositoryHash() =>
    r'71fd693ae860639d145486f888eca14ed8f95b47';

/// See also [transactionRepository].
@ProviderFor(transactionRepository)
final transactionRepositoryProvider =
    AutoDisposeProvider<TransactionRepository>.internal(
  transactionRepository,
  name: r'transactionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionRepositoryRef
    = AutoDisposeProviderRef<TransactionRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
