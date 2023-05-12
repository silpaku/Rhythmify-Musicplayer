// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recentlymodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyplayedModelAdapter extends TypeAdapter<RecentlyplayedModel> {
  @override
  final int typeId = 2;

  @override
  RecentlyplayedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyplayedModel(
      songname: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      songurl: fields[3] as String?,
      id: fields[4] as int?,
      index: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyplayedModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songurl)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyplayedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
