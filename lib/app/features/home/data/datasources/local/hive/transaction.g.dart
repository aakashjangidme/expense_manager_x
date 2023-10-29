// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionImplAdapter extends TypeAdapter<_$TransactionImpl> {
  @override
  final int typeId = 0;

  @override
  _$TransactionImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TransactionImpl(
      id: fields[0] as int?,
      transactionTitle: fields[1] as String?,
      txnType: fields[2] as TxnType?,
      transactionSource: fields[3] as String?,
      transactionDate: fields[4] as DateTime?,
      transactionAmount: fields[5] as double?,
      transactionCategory: fields[6] as String?,
      txnBody: fields[7] as String?,
      isDismissed: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TransactionImpl obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.transactionTitle)
      ..writeByte(2)
      ..write(obj.txnType)
      ..writeByte(3)
      ..write(obj.transactionSource)
      ..writeByte(4)
      ..write(obj.transactionDate)
      ..writeByte(5)
      ..write(obj.transactionAmount)
      ..writeByte(6)
      ..write(obj.transactionCategory)
      ..writeByte(7)
      ..write(obj.txnBody)
      ..writeByte(8)
      ..write(obj.isDismissed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
