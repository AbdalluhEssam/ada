// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveNotesModelAdapter extends TypeAdapter<HiveNotesModel> {
  @override
  final int typeId = 0;

  @override
  HiveNotesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveNotesModel(
      noteId: fields[0] as String?,
      title: fields[1] as String?,
      content: fields[2] as String?,
      usersId: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveNotesModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.noteId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.usersId)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveNotesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
