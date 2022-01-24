import 'dart:convert';
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
          'Content-Type': 'application/json',
          'Authorization': 'Apisecret $videoCipherAppSecret'
        },
      );
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      EmbedInfo movieinfo = EmbedInfo.streaming(
        otp: '${responseBody['otp']}',
        playbackInfo: responseBody['playbackInfo'],
        embedInfoOptions: const EmbedInfoOptions(
            autoplay: true,
            disableAnalytics: false,
            resumePosition: Duration(seconds: 150)),
      );
      return movieinfo;
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
