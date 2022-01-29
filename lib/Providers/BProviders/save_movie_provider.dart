import 'package:flutter/cupertino.dart';

class MovieStateProvider extends ChangeNotifier {
  String? movieID;
  String? backdropPath;
  String? title;
  String? description;
  String? posterpath;
  Duration? saveDuration;

  changeMovieStateForContinueWatching({
    String? movieID,
    String? backdropPath,
    String? title,
    String? description,
    String? posterPath,
  }) {
    this.movieID = movieID!;
    this.backdropPath = backdropPath!;
    posterpath = posterPath!;
    this.title = title!;
    this.description = description!;

    notifyListeners();
  }

  saveDurationForCurrentMovie(Duration? duration) {
    if (duration!.inSeconds == 0) {
      return;
    }

    saveDuration = duration;
    notifyListeners();
  }
}
