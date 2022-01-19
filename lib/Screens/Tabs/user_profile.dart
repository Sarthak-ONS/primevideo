import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prime_video/Providers/BProviders/trending_provider.dart';
import 'package:prime_video/Screens/movie_description_page.dart';
import 'package:prime_video/Widgets/custom_spacer.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:prime_video/routes.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(FirebaseAuth.instance.currentUser!.photoURL);
                      },
                      child: CircleAvatar(
                        radius: 43,
                        backgroundColor: PrimeColors.primaryBlueColor,
                        child: CircleAvatar(
                          backgroundColor: PrimeColors.primaryBlueColor,
                          radius: 40,
                          backgroundImage: NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL !=
                                    "null"
                                ? "https://images.pexels.com/photos/8350511/pexels-photo-8350511.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                                : "",
                          ),
                        ),
                      ),
                    ),
                    buildWidthSizedBox(width: 25),
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName == null
                          ? ""
                          : FirebaseAuth.instance.currentUser!.displayName!,
                      style: const TextStyle(
                        color: Colors.white,
                        //fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                buildHeightSizedBox(height: 15),
                Divider(
                  thickness: 1.5,
                  color: PrimeColors.primaryBlueColor,
                ),
                buildHeightSizedBox(height: 20),
                const Text(
                  'Watchlist',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 17,
                  ),
                ),
                buildHeightSizedBox(height: 25),
                Expanded(
                  child: FutureBuilder(
                    future: Provider.of<MovieProvider>(context)
                        .watchListMovieProvider,
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final tempSnap =
                          snapshot.data!.get("listOfMoviesForWatchList");
                      return ListView.builder(
                        itemCount: tempSnap.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            createRoute(
                              MovieDescriptionScreen(
                                movieID: tempSnap[index]['id'],
                                backdrop_poster: tempSnap[index]
                                    ['backdrop_path'],
                                movie_name: tempSnap[index]['name'],
                                description: tempSnap[index]['overview'],
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: PrimeColors.primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: PrimeColors.primaryBlueColor)),
                            height: 110,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    tempSnap[index]['backdrop_path'],
                                    height: 100,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            right: 13.0, left: 10),
                                        child: Text(
                                          tempSnap[index]['name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            right: 13.0, left: 10),
                                        child: Text(
                                          '${tempSnap[index]['release_date']}, ${tempSnap[index]['duration'].toString().substring(0, 4)}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Poppins',
                                            color: PrimeColors.primaryBlueColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                buildHeightSizedBox()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
