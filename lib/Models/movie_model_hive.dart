import 'package:hive/hive.dart';

part 'movie_model_hive.g.dart';

@HiveType(typeId: 0)
class HiveMovieModel extends HiveObject {
  @HiveField(0)
  bool? adult;

  @HiveField(1)
  String? backdropPath;

  @HiveField(2)
  String? id;

  @HiveField(3)
  String? originalLanguage;

  @HiveField(4)
  String? originalTitle;

  @HiveField(5)
  String? posterPath;

  @HiveField(6)
  String? title;

  @HiveField(7)
  bool? video;

  @HiveField(8)
  String? overview;

  @HiveField(9)
  List<int>? genreIds;

  @HiveField(10)
  String? mediaType;

  @HiveField(11)
  String? downloadedPath;
}
