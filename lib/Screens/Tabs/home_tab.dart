import 'package:flutter/material.dart';
import 'package:prime_video/Models/movie_model.dart';
import 'package:prime_video/Providers/BProviders/current_user_provider.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/Widgets/media_prime.dart';
import 'package:prime_video/Widgets/trending_media.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:provider/provider.dart';
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
    final res = await _tmdb!.v3.movies.getSimilar(14072);

    final moviesListFromServer = res['results'];

    for (int i = 0; i < moviesListFromServer.length; i++) {
      _movieListsForTrending.add(
        movielModel.fromJson(moviesListFromServer[i]),
      );
    }
    print(moviesListFromServer.length);
  }

  List<movielModel> _movieListsForTrending = [];

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      floatingActionButton: FloatingActionButton(onPressed: () async {
        print(Provider.of<CurrentUserProvider>(context, listen: false).name);
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
          //TODO: For Continue Watching
          //// Container For Top Rated

          Container(
            padding: EdgeInsets.only(left: 5),
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
}
