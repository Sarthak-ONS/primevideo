import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:prime_video/Screens/home_screen.dart';
import 'package:prime_video/prime_colors.dart';
import 'package:video_player/video_player.dart';

String trailerUrl =
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";

class PlayVideoForMovies extends StatefulWidget {
  const PlayVideoForMovies({Key? key}) : super(key: key);

  @override
  _PlayVideoForMoviesState createState() => _PlayVideoForMoviesState();
}

class _PlayVideoForMoviesState extends State<PlayVideoForMovies> {
  final videoPlayerController = VideoPlayerController.network(trailerUrl);

  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      fullScreenByDefault: true,
      showControlsOnInitialize: false,
      materialProgressColors:
          ChewieProgressColors(backgroundColor: Colors.transparent),
      cupertinoProgressColors: ChewieProgressColors(),
      placeholder: const Center(
        child: Text(
          'Your Video is being loaded',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      autoPlay: true,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      aspectRatio: 16 / 9,
      // showControls: true,
      allowPlaybackSpeedChanging: true,
      startAt: const Duration(seconds: 0),
      customControls: CupertinoControls(
        backgroundColor: Colors.transparent,
        iconColor: Colors.white,
      ),
      looping: false,
      showControls: true,
    );
    chewieController!.enterFullScreen();
    chewieController!.addListener(() {
      if (chewieController!.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: chewieController!,
    );
  }
}

class PlayVideo extends StatefulWidget {
  const PlayVideo({Key? key}) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: PlayVideoForMovies(),
    );
  }
}
