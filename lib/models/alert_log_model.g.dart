// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlertLogModelAdapter extends TypeAdapter<AlertLogModel> {
  @override
  final int typeId = 3;

  @override
  AlertLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlertLogModel(
      id: fields[0] as String,
      buttonId: fields[1] as String,
      timestamp: fields[2] as DateTime,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      userId: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AlertLogModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.buttonId)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
