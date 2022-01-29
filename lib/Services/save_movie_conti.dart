import 'package:hive/hive.dart';
import 'package:prime_video/Models/movie_model_hive.dart';

class SaveMovietoContinueWatching {
  late Box? continueWatching;
}

class Boxes {
  static Box<HiveMovieModel> getContinueWatching() =>
      Hive.box<HiveMovieModel>('continuewatching');
}
