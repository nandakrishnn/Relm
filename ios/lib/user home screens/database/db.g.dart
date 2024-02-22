// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataModelAdapter extends TypeAdapter<DataModel> {
  @override
  final int typeId = 0;

  @override
  DataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataModel(
      id: fields[0] as int?,
      uname: fields[1] as String?,
      email: fields[2] as String?,
      password: fields[3] as String?,
      imageprof: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uname)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.imageprof);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DatamodelcatAdapter extends TypeAdapter<Datamodelcat> {
  @override
  final int typeId = 1;

  @override
  Datamodelcat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Datamodelcat(
      id1: fields[0] as int?,
      catimage: fields[1] as String,
      catname: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Datamodelcat obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id1)
      ..writeByte(1)
      ..write(obj.catimage)
      ..writeByte(2)
      ..write(obj.catname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatamodelcatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
