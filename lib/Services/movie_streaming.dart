import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:prime_video/private_variable.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

class StreamingVideo {
  final String urlx =
      "https://dev.vdocipher.com/api/videos/a91709aaaaf64bdc9bafd2ef359711c5/otp";

  Future startSecureStreaming() async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          urlx,
        ),
        headers: {
          "Accept": "application/json",
          // 'Content-Type': 'application/json',
          'Authorization': 'Apisecret $videoCipherAppSecret'
        },
        body: {
          "licenseRules": jsonEncode({
            "canPersist": true,
            "rentalDuration": 15 * 24 * 3600,
          })
        },
      );
      final responseBody = jsonDecode(response.body);

      print(responseBody);
      EmbedInfo movieStreaminginfo = EmbedInfo.streaming(
        otp: '${responseBody['otp']}',
        playbackInfo: responseBody['playbackInfo'],
        embedInfoOptions: const EmbedInfoOptions(
          autoplay: true,
          disableAnalytics: false,
          resumePosition: Duration(seconds: 0),
          allowAdbDebugging: true,
        ),
      );

      EmbedInfo movieOfflineInfo = const EmbedInfo.offline(
        mediaId: 'a91709aaaaf64bdc9bafd2ef359711c5',
        embedInfoOptions: EmbedInfoOptions(
          autoplay: true,
          disableAnalytics: false,
          resumePosition: Duration(seconds: 0),
        ),
      );

      return movieStreaminginfo;
    } catch (e) {
      print(e.toString());
    }
  }

  Future startOfflineVideoStreaming() async {}

  Future getResponse() async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          urlx,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Apisecret $videoCipherAppSecret'
        },
      );
      final responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
