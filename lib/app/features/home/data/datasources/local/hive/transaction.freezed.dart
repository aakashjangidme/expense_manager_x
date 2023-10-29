// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Transaction {
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get transactionTitle => throw _privateConstructorUsedError;
  @HiveField(2)
  TxnType? get txnType => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get transactionSource => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime? get transactionDate => throw _privateConstructorUsedError;
  @HiveField(5)
  double? get transactionAmount => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get transactionCategory => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get txnBody => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {@HiveField(0) int? id,
      @HiveField(1) String? transactionTitle,
      @HiveField(2) TxnType? txnType,
      @HiveField(3) String? transactionSource,
      @HiveField(4) DateTime? transactionDate,
      @HiveField(5) double? transactionAmount,
      @HiveField(6) String? transactionCategory,
      @HiveField(7) String? txnBody});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? transactionTitle = freezed,
    Object? txnType = freezed,
    Object? transactionSource = freezed,
    Object? transactionDate = freezed,
    Object? transactionAmount = freezed,
    Object? transactionCategory = freezed,
    Object? txnBody = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      transactionTitle: freezed == transactionTitle
          ? _value.transactionTitle
          : transactionTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      txnType: freezed == txnType
          ? _value.txnType
          : txnType // ignore: cast_nullable_to_non_nullable
              as TxnType?,
      transactionSource: freezed == transactionSource
          ? _value.transactionSource
          : transactionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionDate: freezed == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transactionAmount: freezed == transactionAmount
          ? _value.transactionAmount
          : transactionAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      transactionCategory: freezed == transactionCategory
          ? _value.transactionCategory
          : transactionCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      txnBody: freezed == txnBody
          ? _value.txnBody
          : txnBody // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
          _$TransactionImpl value, $Res Function(_$TransactionImpl) then) =
      __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int? id,
      @HiveField(1) String? transactionTitle,
      @HiveField(2) TxnType? txnType,
      @HiveField(3) String? transactionSource,
      @HiveField(4) DateTime? transactionDate,
      @HiveField(5) double? transactionAmount,
      @HiveField(6) String? transactionCategory,
      @HiveField(7) String? txnBody});
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
      _$TransactionImpl _value, $Res Function(_$TransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? transactionTitle = freezed,
    Object? txnType = freezed,
    Object? transactionSource = freezed,
    Object? transactionDate = freezed,
    Object? transactionAmount = freezed,
    Object? transactionCategory = freezed,
    Object? txnBody = freezed,
  }) {
    return _then(_$TransactionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      transactionTitle: freezed == transactionTitle
          ? _value.transactionTitle
          : transactionTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      txnType: freezed == txnType
          ? _value.txnType
          : txnType // ignore: cast_nullable_to_non_nullable
              as TxnType?,
      transactionSource: freezed == transactionSource
          ? _value.transactionSource
          : transactionSource // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionDate: freezed == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transactionAmount: freezed == transactionAmount
          ? _value.transactionAmount
          : transactionAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      transactionCategory: freezed == transactionCategory
          ? _value.transactionCategory
          : transactionCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      txnBody: freezed == txnBody
          ? _value.txnBody
          : txnBody // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 0)
class _$TransactionImpl extends _Transaction {
  _$TransactionImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.transactionTitle,
      @HiveField(2) required this.txnType,
      @HiveField(3) required this.transactionSource,
      @HiveField(4) required this.transactionDate,
      @HiveField(5) required this.transactionAmount,
      @HiveField(6) required this.transactionCategory,
      @HiveField(7) required this.txnBody})
      : super._();

  @override
  @HiveField(0)
  final int? id;
  @override
  @HiveField(1)
  final String? transactionTitle;
  @override
  @HiveField(2)
  final TxnType? txnType;
  @override
  @HiveField(3)
  final String? transactionSource;
  @override
  @HiveField(4)
  final DateTime? transactionDate;
  @override
  @HiveField(5)
  final double? transactionAmount;
  @override
  @HiveField(6)
  final String? transactionCategory;
  @override
  @HiveField(7)
  final String? txnBody;

  @override
  String toString() {
    return 'Transaction(id: $id, transactionTitle: $transactionTitle, txnType: $txnType, transactionSource: $transactionSource, transactionDate: $transactionDate, transactionAmount: $transactionAmount, transactionCategory: $transactionCategory, txnBody: $txnBody)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionTitle, transactionTitle) ||
                other.transactionTitle == transactionTitle) &&
            (identical(other.txnType, txnType) || other.txnType == txnType) &&
            (identical(other.transactionSource, transactionSource) ||
                other.transactionSource == transactionSource) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            (identical(other.transactionAmount, transactionAmount) ||
                other.transactionAmount == transactionAmount) &&
            (identical(other.transactionCategory, transactionCategory) ||
                other.transactionCategory == transactionCategory) &&
            (identical(other.txnBody, txnBody) || other.txnBody == txnBody));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      transactionTitle,
      txnType,
      transactionSource,
      transactionDate,
      transactionAmount,
      transactionCategory,
      txnBody);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);
}

abstract class _Transaction extends Transaction {
  factory _Transaction(
      {@HiveField(0) required final int? id,
      @HiveField(1) required final String? transactionTitle,
      @HiveField(2) required final TxnType? txnType,
      @HiveField(3) required final String? transactionSource,
      @HiveField(4) required final DateTime? transactionDate,
      @HiveField(5) required final double? transactionAmount,
      @HiveField(6) required final String? transactionCategory,
      @HiveField(7) required final String? txnBody}) = _$TransactionImpl;
  _Transaction._() : super._();

  @override
  @HiveField(0)
  int? get id;
  @override
  @HiveField(1)
  String? get transactionTitle;
  @override
  @HiveField(2)
  TxnType? get txnType;
  @override
  @HiveField(3)
  String? get transactionSource;
  @override
  @HiveField(4)
  DateTime? get transactionDate;
  @override
  @HiveField(5)
  double? get transactionAmount;
  @override
  @HiveField(6)
  String? get transactionCategory;
  @override
  @HiveField(7)
  String? get txnBody;
  @override
  @JsonKey(ignore: true)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
