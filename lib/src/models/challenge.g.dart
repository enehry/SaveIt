// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChallengesAdapter extends TypeAdapter<Challenge> {
  @override
  final int typeId = 1;

  @override
  Challenge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Challenge(
      id: fields[0] as String,
      title: fields[1] as String,
      iconCode: fields[3] as int,
      total: fields[5] as double,
      dateCreated: fields[7] as DateTime,
      startDate: fields[9] as DateTime,
      endDate: fields[10] as DateTime,
      frequency: fields[11] as String,
      description: fields[2] as String?,
      dateUpdated: fields[8] as DateTime?,
      deposits: (fields[12] as List).cast<Deposit>(),
      isSync: fields[13] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Challenge obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.iconCode)
      ..writeByte(5)
      ..write(obj.total)
      ..writeByte(7)
      ..write(obj.dateCreated)
      ..writeByte(8)
      ..write(obj.dateUpdated)
      ..writeByte(9)
      ..write(obj.startDate)
      ..writeByte(10)
      ..write(obj.endDate)
      ..writeByte(11)
      ..write(obj.frequency)
      ..writeByte(12)
      ..write(obj.deposits)
      ..writeByte(13)
      ..write(obj.isSync);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
