// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddNoteUserAdapter extends TypeAdapter<AddNoteUser> {
  @override
  final int typeId = 3;

  @override
  AddNoteUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddNoteUser(
      description: fields[2] as String?,
      title: fields[1] as String?,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AddNoteUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddNoteUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
