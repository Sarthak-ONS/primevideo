import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:prime_video/Screens/movie_description_page.dart';
import 'package:prime_video/routes.dart';

class FirebaseDynamicLinkApi {
  final FirebaseDynamicLinks _firebaseDynamicLinks =
      FirebaseDynamicLinks.instance;

  Future init(context) async {
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData dynamicLinkData) {
        try {
          final queryParams = dynamicLinkData.link.queryParameters;
          Navigator.of(context).push(
            createRoute(
              MovieDescriptionScreen(
                movieID: queryParams['u'] as int,
                moviename: queryParams['t'],
                description: queryParams['d'],
                backdropposter: queryParams['i'],
              ),
            ),
          );
        } catch (e) {}
      },
      onError: (e) {
        print(e);
      },
      onDone: () {
        print("Succesfully done d links");
      },
    );
  }

  Future createDynmicLink({
    required String movieID,
    required String description,
    required String imageUrl,
    required String movieName,
  }) async {
    try {
      final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
        uriPrefix: "https://primevideoclone.page.link",
        link: Uri.parse(
            "https://www.proshare.in/m/?u=$movieID&t=$Title&d=$description&i=$imageUrl"),
        androidParameters:
            const AndroidParameters(packageName: 'com.sarthak.prime_video'),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: movieName,
          description: description,
          imageUrl: Uri.parse(imageUrl),
        ),
      );

      ShortDynamicLink shortDynamicLink =
          await _firebaseDynamicLinks.buildShortLink(dynamicLinkParameters);

      return shortDynamicLink.shortUrl;
    } catch (e) {
      print(e.toString());
    }
  }
}
