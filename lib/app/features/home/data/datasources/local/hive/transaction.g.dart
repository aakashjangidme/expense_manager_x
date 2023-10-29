// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      id: fields[0] as int?,
      transactionTitle: fields[1] as String?,
      transactionCategory: fields[6] as String?,
      txnType: fields[2] as TxnType?,
      transactionSource: fields[3] as String?,
      transactionDate: fields[4] as DateTime?,
      transactionAmount: fields[5] as double?,
      txnBody: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.txnBody);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
