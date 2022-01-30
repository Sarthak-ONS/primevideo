import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prime_video/Models/movie_model_hive.dart';
import 'package:prime_video/Services/multiple_login_service.dart';
import 'package:prime_video/Services/save_movie_conti.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/media_prime.dart';
import 'package:prime_video/Widgets/play_video.dart';
import 'package:prime_video/Widgets/trending_media.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:prime_video/routes.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../private_variable.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

TMDB? _tmdb;

class _HomeTabState extends State<HomeTab> {
  Future loadMovies() async {
    _tmdb = TMDB(
      ApiKeys(apiKeys, token),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
        showInfoLogs: true,
      ),
    );
    final res = await _tmdb!.v3.tv.getLatest(language: 'hi');

    final moviesListFromServer = res['seasons'];

    final temp = res;

    // for (int i = 0; i < moviesListFromServer.length; i++) {
    //   _movieListsForTrending.add(
    //     movielModel.fromJson(moviesListFromServer[i]),
    //   );
    // }
    print(temp);

    print(moviesListFromServer);
  }

  final List _movieListsForTrending = [];

  initiateBoxes() async {
    box = await Hive.openBox<HiveMovieModel>('continuewatching');
  }

  @override
  void initState() {
    //loadMovies();
    initiateBoxes();
    super.initState();
  }

  Future addMovieToContinueWatching() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      floatingActionButton: FloatingActionButton(onPressed: () async {
        CheckForMultiPleLogins().checkNoofTokensinDatabase();
        // final box = Boxes.getContinueWatching();
        // box.add(HiveMovieModel());

        // loadMovies();
      }),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        children: [
          //Trending Container
          const SizedBox(
            height: 210,
            child: TrendingMovies(),
          ),
          // For Continue Watching
          //
          SizedBox(
            height: 220,
            child: Container(
              margin: const EdgeInsets.only(top: 15.0),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: PrimeColors.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Continue Watching',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Colors.white),
                  ),
                  buildHeightSizedBox(height: 4),
                  SizedBox(
                    height: 170,
                    child: ValueListenableBuilder<Box<HiveMovieModel>>(
                      valueListenable: Boxes.getContinueWatching().listenable(),
                      builder: (context, box, _) {
                        final movies =
                            box.values.toList().cast<HiveMovieModel>();

                        if (movies.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(15.0),
                            child: const Center(
                              child: Text(
                                'Watch Something',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          );
                        }

                        return buildContinueWatchingCard(movies);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          //// Container For Top Rated
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              children: [
                SizedBox(
                  height: 220,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: PrimeColors.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Top Rated Movies',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                        buildHeightSizedBox(height: 4),
                        const SizedBox(
                          height: 170,
                          child: TopRatedMedia(),
                        )
                      ],
                    ),
                  ),
                ),
                // Container For Recommended Movies
                SizedBox(
                  height: 220,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: PrimeColors.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recommended',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                        buildHeightSizedBox(height: 4),
                        const SizedBox(
                          height: 170,
                          child: RecommendedMedia(),
                        )
                      ],
                    ),
                  ),
                ),
                // Container For Upcoming Movies
                SizedBox(
                  height: 220,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: PrimeColors.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upcoming Movies',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                        buildHeightSizedBox(height: 4),
                        const SizedBox(
                          height: 170,
                          child: UpcomingMedia(),
                        )
                      ],
                    ),
                  ),
                ),
                // COntainer For Now Playing
                SizedBox(
                  height: 220,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: PrimeColors.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Now Playing',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                        buildHeightSizedBox(height: 4),
                        const SizedBox(
                          height: 170,
                          child: NowPlaying(),
                        )
                      ],
                    ),
                  ),
                ),
                // Container For Language
                // SizedBox(
                //   height: 220,
                //   child: Container(
                //     margin: const EdgeInsets.only(top: 15.0),
                //     //padding: const EdgeInsets.symmetric(horizontal: 5),
                //     color: PrimeColors.primaryColor,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           'Watch in Your Language',
                //           style: TextStyle(
                //               fontSize: 18,
                //               fontFamily: 'Poppins',
                //               color: Colors.white),
                //         ),
                //         buildHeightSizedBox(height: 4),
                //         const SizedBox(
                //           height: 170,
                //           child: BuildLanguageWidget(),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          )

          //
        ],
      ),
    );
  }

  ListView buildContinueWatchingCard(List<HiveMovieModel> movies) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          print(movies[index]);
          Navigator.of(context).push(
            createRoute(
              VdoPlaybackView(
                movieID: movies[index].movieID,
                description: movies[index].description,
                backdropPoster: movies[index].backdropPath,
                duration: Duration(seconds: movies[index].duration!),
                posterpath: movies[index].backdropPath,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: PrimeColors.primaryColor),
          height: 150,
          width: 130,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Image.network(
            movies[index].backdropPath!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}


// DownloadApi().downloadAMovie(
//     downloadMovieName: 'Sarah', downloadMovieID: '12345');

// _movieListsForTrending.clear();
// for (var item in _movieListsForTrending) {
//   FirebaseFirestore.instance.collection('Now Playing').add(
//     {
//       "id": item.id,
//       "name": item.title,
//       "originallanguage": item.originalLanguage,
//       "overview": item.overview,
//       "isAdult": item.adult,
//       "backdrop_path":
//           "https://image.tmdb.org/t/p/w500${item.backdropPath}",
//       "poster_path":
//           "https://image.tmdb.org/t/p/w500${item.posterPath}",
//       "populartity": item.popularity,
//       "rating": item.voteAverage,
//       "release_date": item.releaseDate,
//       "media_type": item.mediaType,
//       "movie_cast_link": ""
//     },
//   );
// }

