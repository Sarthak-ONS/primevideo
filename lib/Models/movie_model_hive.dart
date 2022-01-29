import 'package:hive/hive.dart';

part 'movie_model_hive.g.dart';

@HiveType(typeId: 0)
class HiveMovieModel extends HiveObject {
  @HiveField(0)
  late String? movieID;

  @HiveField(1)
  late String? backdropPath;

  @HiveField(2)
  late String? id;

  @HiveField(3)
  String? title;

  @HiveField(4)
  String? description;

  @HiveField(5)
  int? duration;
}
