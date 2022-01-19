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
      ..adult = fields[0] as bool?
      ..backdropPath = fields[1] as String?
      ..id = fields[2] as String?
      ..originalLanguage = fields[3] as String?
      ..originalTitle = fields[4] as String?
      ..posterPath = fields[5] as String?
      ..title = fields[6] as String?
      ..video = fields[7] as bool?
      ..overview = fields[8] as String?
      ..genreIds = (fields[9] as List?)?.cast<int>()
      ..mediaType = fields[10] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveMovieModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.backdropPath)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.originalLanguage)
      ..writeByte(4)
      ..write(obj.originalTitle)
      ..writeByte(5)
      ..write(obj.posterPath)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.video)
      ..writeByte(8)
      ..write(obj.overview)
      ..writeByte(9)
      ..write(obj.genreIds)
      ..writeByte(10)
      ..write(obj.mediaType);
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
