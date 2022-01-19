import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prime_video/Models/movie_model_hive.dart';
import 'package:prime_video/Models/single_movie_model.dart';
import 'package:prime_video/Providers/BProviders/trending_provider.dart';
import 'package:prime_video/Services/firestore_service.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/play_video.dart';
import 'package:prime_video/Widgets/primary_button.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:prime_video/routes.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../private_variable.dart';

class MovieDescriptionScreen extends StatefulWidget {
  const MovieDescriptionScreen(
      {Key? key,
      this.backdrop_poster,
      this.movieID,
      this.movie_name,
      this.description})
      : super(key: key);

  final movieID;
  final backdrop_poster;
  final movie_name;
  final description;

  @override
  _MovieDescriptionScreenState createState() => _MovieDescriptionScreenState();
}

class _MovieDescriptionScreenState extends State<MovieDescriptionScreen> {
  getMovieCompleteData() async {
    //
    print("////");
    TMDB _tmdb = TMDB(
      ApiKeys(apiKeys, token),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
        showInfoLogs: true,
      ),
    );
    final res = await _tmdb.v3.movies.getDetails(widget.movieID);
    singleMovieModel = SingleMovieModel.fromJson(res);

    for (var i = 0; i < singleMovieModel!.genres!.length; i++) {
      if (!genreList!.contains(singleMovieModel!.genres![i].name)) {
        genreList!.add(singleMovieModel!.genres![i].name);
      }
    }

    print(genreList);
  }

  SingleMovieModel? singleMovieModel;

  List? genreList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await getMovieCompleteData();
            await FirebaseFirestore.instance
                .collection('AllMovies')
                .doc(widget.movieID.toString())
                .set(
              {
                "adult": singleMovieModel!.adult,
                "belongs_to_collection": singleMovieModel!.belongsToCollection,
                "release_date": singleMovieModel!.releaseDate,
                "duration": singleMovieModel!.runtime,
                "ratings": singleMovieModel!.voteAverage,
                "genre": [...genreList!],
                "original_title": singleMovieModel!.originalTitle,
                "original_language": singleMovieModel!.originalLanguage,
                "tagline": singleMovieModel!.tagline,
              },
            ).then((value) => print("Done"));
          },
        ),
        backgroundColor: PrimeColors.primaryColor,
        body: Stack(
          children: [
            FutureBuilder(
              future: Provider.of<MovieProvider>(context)
                  .returnSingleMovieProviderFuture(widget.movieID.toString()),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text(
                      'Please try again later',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return ListView(
                  children: [
                    //Container For Poster
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      color: PrimeColors.primaryColor,
                      child: Image.network(
                        widget.backdrop_poster!,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 15.0,
                            ),
                            child: Text(
                              widget.movie_name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          buildPrimaryButton(
                            () {
                              Navigator.of(context).push(
                                createRoute(
                                  const PlayVideo(),
                                ),
                              );
                            },
                            'Watch Now',
                            color: PrimeColors.primaryBlueColor,
                            isWatchNow: true,
                          )
                          //Trailer Download WatchList Share
                          ,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MovieDescriptionControlWidget(
                                  icons: Icons.play_circle_fill_outlined,
                                  title: 'Trailer',
                                  callback: () {
                                    print("Playing trailer");
                                  },
                                ),
                                MovieDescriptionControlWidget(
                                  icons: Icons.download_for_offline,
                                  title: 'Download',
                                  callback: () {},
                                ),
                                MovieDescriptionControlWidget(
                                  icons: Icons.watch_later_outlined,
                                  title: 'Watchlist',
                                  callback: () {
                                    // addthisMovietoWatchList(
                                    //   adult: snapshot.data!.get("adult"),
                                    //   backdropPath: widget.backdrop_poster,
                                    //   movieId: widget.movieID.toString(),
                                    //   title: widget.movie_name,
                                    // );

                                    FirebaseFirestoreApi().addMovietoWatchList(
                                      widget.movieID.toString(),
                                      widget.movie_name,
                                      widget.backdrop_poster,
                                      widget.backdrop_poster,
                                      widget.description,
                                      snapshot.data!.get("release_date"),
                                      snapshot.data!.get("duration").toString(),
                                    );
                                  },
                                ),
                                MovieDescriptionControlWidget(
                                  icons: Icons.share,
                                  title: 'Share',
                                  callback: () {},
                                ),
                              ],
                            ),
                          )
                          //
                          ,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              widget.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          buildHeightSizedBox(height: 15),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: snapshot.data!.get("release_date") == null ||
                                    snapshot.data!.get("duration") == null
                                ? const Text("")
                                : Text(
                                    '${snapshot.data!.get("release_date").toString().substring(0, 4)}, ${snapshot.data!.get("duration")}min,',
                                    style: TextStyle(
                                      color: PrimeColors.primaryBlueColor
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                          // ${snapshot.data!.get("ratings")}stars
                          buildHeightSizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: snapshot.data!.get("ratings") == null
                                ? const Text("")
                                : Text(
                                    'Ratings:  ${snapshot.data!.get("ratings")}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                          buildHeightSizedBox(height: 25),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Genre',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          snapshot.data!.get("genre") == null
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          snapshot.data!.get("genre").length,
                                      itemBuilder: (_, index) {
                                        return snapshot.data!
                                                    .get("genre")[index] ==
                                                null
                                            ? const Text("")
                                            : Text(
                                                '${snapshot.data!.get("genre")[index]}, ',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              );
                                      },
                                    ),
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}

Future addthisMovietoWatchList({
  required bool adult,
  required String backdropPath,
  required String movieId,
  required String title,
}) async {
  final movieModeltobeaddedtoHive = HiveMovieModel()
    ..adult = adult
    ..backdropPath = backdropPath
    ..id = movieId
    ..title = title;

  final box = Hive.box('hivemoviemodelwatchlist');
  print(movieId);

  List boxKeys = box.keys.toList();
  if (boxKeys.contains(movieId)) {
    print("Movie was already watchListed. ");
    print("Cancelling Operation for adding movies");
    return;
  }

  box
      .put(
        movieId,
        movieModeltobeaddedtoHive,
      )
      .then(
        (value) => print("Movie Successfully Added to the Database,"),
      );
}

class MovieDescriptionControlWidget extends StatelessWidget {
  const MovieDescriptionControlWidget(
      {Key? key,
      required this.icons,
      required this.title,
      required this.callback})
      : super(key: key);

  final IconData icons;
  final String title;
  final callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            callback();
          },
          child: CircleAvatar(
            radius: 21,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              backgroundColor: PrimeColors.primaryColor,
              radius: 20,
              child: Icon(
                icons,
                size: 25,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        buildHeightSizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

class Boxes {
  static Box<HiveMovieModel> getWatchListBox() =>
      Hive.box<HiveMovieModel>('hiveMovieModelWatchlist');
}
