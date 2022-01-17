// To parse this JSON data, do
//
//     final movielModel = movielModelFromJson(jsonString);

import 'dart:convert';

movielModel movielModelFromJson(String str) =>
    movielModel.fromJson(json.decode(str));

String movielModelToJson(movielModel data) => json.encode(data.toJson());

class movielModel {
  movielModel({
    this.adult,
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.overview,
    this.genreIds,
    this.popularity,
    this.mediaType,
  });

  bool? adult;
  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? posterPath;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? overview;
  DateTime? releaseDate;
  List<int>? genreIds;
  double? popularity;
  String? mediaType;

  factory movielModel.fromJson(Map<String, dynamic> json) => movielModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        overview: json["overview"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        mediaType: json["media_type"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "poster_path": posterPath,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "overview": overview,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "media_type": mediaType,
      };
}
