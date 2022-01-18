import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prime_video/Providers/BProviders/trending_provider.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:provider/provider.dart';

class TopRatedMedia extends StatelessWidget {
  const TopRatedMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TrendingMovieProvider>(context).topRatedMedia,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: PrimeColors.primaryColor),
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.network(
                  snapshot.data!.docs[index].get("poster_path"),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class RecommendedMedia extends StatelessWidget {
  const RecommendedMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TrendingMovieProvider>(context).recommendedMedia,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: PrimeColors.primaryColor),
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.network(
                  snapshot.data!.docs[index].get("poster_path"),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class UpcomingMedia extends StatelessWidget {
  const UpcomingMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TrendingMovieProvider>(context).upcomingMedia,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: PrimeColors.primaryColor),
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.network(
                  snapshot.data!.docs[index].get("poster_path"),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class NowPlaying extends StatelessWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TrendingMovieProvider>(context).nowPlaying,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: PrimeColors.primaryColor),
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.network(
                  snapshot.data!.docs[index].get("poster_path"),
                ),
              );
            },
          );
        }
      },
    );
  }
}
