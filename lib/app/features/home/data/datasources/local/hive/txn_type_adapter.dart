import 'package:hive/hive.dart';

import '../../../../../../core/configs/constants.dart';



class TxnTypeAdapter extends TypeAdapter<TxnType> {
  @override
  TxnType read(BinaryReader reader) {
    final index = reader.readByte();
    return TxnType.values[index];
  }

  @override
  void write(BinaryWriter writer, TxnType obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get typeId => 1;
}
