import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prime_video/Providers/BProviders/trending_provider.dart';
import 'package:prime_video/Screens/movie_description_page.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:prime_video/routes.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TrendingMovies extends StatefulWidget {
  const TrendingMovies({Key? key}) : super(key: key);

  @override
  _TrendingMoviesState createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MovieProvider>(context).trendingMedia,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return ListView.builder(
          itemBuilder: (context, index) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: 200,
                  color: PrimeColors.primaryColor,
                ),
              );
            }
            return CarouselSlider.builder(
              itemCount: snapshot.data!.docs.length,
              options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.decelerate),
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    // print(snapshot.data!.docs[index].get("backdrop_path"));
                    // print(snapshot.data!.docs[index].get("id"));
                    // print(snapshot.data!.docs[index].get("name"));
                    // print(snapshot.data!.docs[index].get("overview"));
                    Navigator.of(context).push(
                      createRoute(
                        MovieDescriptionScreen(
                          backdropposter:
                              snapshot.data!.docs[index].get("backdrop_path"),
                          movieID: snapshot.data!.docs[index].get("id"),
                          moviename: snapshot.data!.docs[index].get("name"),
                          description:
                              snapshot.data!.docs[index].get("overview"),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          snapshot.data!.docs[index].get("backdrop_path"),
                          scale: 1,
                        ),
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.fitHeight,
                        onError: (exception, stackTrace) {
                          print("There is error loading Image $exception");
                          print("Stacktrace is $stackTrace");
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
