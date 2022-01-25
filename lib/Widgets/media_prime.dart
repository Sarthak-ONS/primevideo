import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prime_video/Providers/BProviders/trending_provider.dart';
import 'package:prime_video/Screens/movie_description_page.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:prime_video/routes.dart';
import 'package:provider/provider.dart';

class TopRatedMedia extends StatelessWidget {
  const TopRatedMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MovieProvider>(context).topRatedMedia,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    createRoute(
                      MovieDescriptionScreen(
                        backdropposter:
                            snapshot.data!.docs[index].get("backdrop_path"),
                        movieID: snapshot.data!.docs[index].get("id"),
                        moviename: snapshot.data!.docs[index].get("name"),
                        description: snapshot.data!.docs[index].get("overview"),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: PrimeColors.primaryColor),
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.network(
                    snapshot.data!.docs[index].get("poster_path"),
                  ),
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
      future: Provider.of<MovieProvider>(context).recommendedMedia,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    createRoute(
                      MovieDescriptionScreen(
                        backdropposter:
                            snapshot.data!.docs[index].get("backdrop_path"),
                        movieID: snapshot.data!.docs[index].get("id"),
                        moviename: snapshot.data!.docs[index].get("name"),
                        description: snapshot.data!.docs[index].get("overview"),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: PrimeColors.primaryColor),
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.network(
                    snapshot.data!.docs[index].get("poster_path"),
                  ),
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
      future: Provider.of<MovieProvider>(context).upcomingMedia,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    createRoute(
                      MovieDescriptionScreen(
                        backdropposter:
                            snapshot.data!.docs[index].get("backdrop_path"),
                        movieID: snapshot.data!.docs[index].get("id"),
                        moviename: snapshot.data!.docs[index].get("name"),
                        description: snapshot.data!.docs[index].get("overview"),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: PrimeColors.primaryColor),
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.network(
                    snapshot.data!.docs[index].get("poster_path"),
                  ),
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
      future: Provider.of<MovieProvider>(context).nowPlaying,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    createRoute(
                      MovieDescriptionScreen(
                        backdropposter:
                            snapshot.data!.docs[index].get("backdrop_path"),
                        movieID: snapshot.data!.docs[index].get("id"),
                        moviename: snapshot.data!.docs[index].get("name"),
                        description: snapshot.data!.docs[index].get("overview"),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: PrimeColors.primaryColor),
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.network(
                    snapshot.data!.docs[index].get("poster_path"),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

// Get Movies By Language .
// Hindi, English, Telgu, Tamil, Malyalam, Kannada, Marathi, Punjabi, Bengali, Gujrati.

List _movies = [
  //Hindi
  "https://media.istockphoto.com/photos/learn-hindi-handwritten-letter-on-blackboard-translation-of-written-picture-id922686498?s=612x612",
  //English
  "https://m.media-amazon.com/images/S/sonata-images-prod/PV_IN_WatchInYourLanguageEnglishBoxartV2/15cfbfa1-3772-4c04-a87c-a31aab146ee5._UR200,200_SX200_FMwebp_.jpg",
  //Telgu,
  "https://m.media-amazon.com/images/G/01/digital/video/sonata/PV_IN_TelDec/930aa201-7920-419a-be3b-19f851d66aae._UR200,200_SX200_FMwebp_.jpg",
  // Kannada,
  "https://m.media-amazon.com/images/G/01/digital/video/sonata/PV_IN_KanDec/872afeb6-6e3c-4238-8425-0fbed8a98d18._UR200,200_SX200_FMwebp_.jpg",
  //Punjabi
  "https://m.media-amazon.com/images/G/01/digital/video/sonata/PV_IN_PunjDec/3b313164-339a-4cb0-9435-ea335f995632._UR200,200_SX200_FMwebp_.jpg",
  // Marathi
  "https://m.media-amazon.com/images/G/01/digital/video/sonata/PV_IN_MarDec/e813e13e-a867-4e5d-989f-c82e3c5be3da._UR200,200_SX200_FMwebp_.jpg"
];

// class BuildLanguageWidget extends StatelessWidget {
//   const BuildLanguageWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _movies.length,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(
//               createRoute(
//                  MovieDescriptionScreen(index: index.toString(),),
//               ),
//             );
//           },
//           child: Container(
//             width: 125,
//             height: 130,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5.0),
//               color: PrimeColors.primaryColor,
//             ),
//             child: Image.network(
//               _movies[index],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
