// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMovieModelAdapter extends TypeAdapter<HiveMovieModel> {
  @override
  final int typeId = 0;

  @override
  HiveMovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMovieModel()
      ..movieID = fields[0] as String?
      ..backdropPath = fields[1] as String?
      ..id = fields[2] as String?
      ..title = fields[3] as String?
      ..description = fields[4] as String?
      ..duration = fields[5] as int?;
  }

  @override
  void write(BinaryWriter writer, HiveMovieModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.movieID)
      ..writeByte(1)
      ..write(obj.backdropPath)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
