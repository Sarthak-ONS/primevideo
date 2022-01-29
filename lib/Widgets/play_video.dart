import 'package:flutter/material.dart';
import 'package:prime_video/Models/movie_model_hive.dart';
import 'package:prime_video/Providers/BProviders/save_movie_provider.dart';
import 'package:prime_video/Services/movie_streaming.dart';
import 'package:prime_video/private_variable.dart';
import 'package:provider/provider.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

class VdoPlaybackView extends StatefulWidget {
  VdoPlaybackView({
    Key? key,
    this.movieID,
    this.title,
    this.description,
    this.backdropPoster,
    this.posterpath,
    this.duration = const Duration(seconds: 0),
  }) : super(key: key);

  final String? movieID;
  final String? title;
  final String? description;
  final String? backdropPoster;
  final String? posterpath;
  Duration? duration;

  @override
  _VdoPlaybackViewState createState() => _VdoPlaybackViewState();
}

class _VdoPlaybackViewState extends State<VdoPlaybackView> {
  VdoPlayerController? _controller;
  final double aspectRatio = 4 / 3;
  final ValueNotifier<bool> _isFullScreen = ValueNotifier(true);

  @override
  void initState() {
    startStreaming();
    super.initState();
  }

  @override
  void dispose() {
    savePosition();
    super.dispose();
  }

  Future addMovieToContinueWatching({
    String? id,
    String? title,
    Duration? duration,
    String? description,
    String? backdropPath,
  }) async {
    HiveMovieModel hiveMovieModel = HiveMovieModel()
      ..id = id
      ..title = title
      ..duration = duration!.inSeconds
      ..description = description
      ..backdropPath = backdropPath
      ..movieID = id;

    await box?.put(id!, hiveMovieModel);
  }

  Future savePosition() async {
    Duration duration = await _controller!.getPosition();
    if (duration.inSeconds == 0) return;

    addMovieToContinueWatching(
      id: Provider.of<MovieStateProvider>(context, listen: false).movieID,
      title: Provider.of<MovieStateProvider>(context, listen: false).title,
      duration:
          Provider.of<MovieStateProvider>(context, listen: false).saveDuration,
      description:
          Provider.of<MovieStateProvider>(context, listen: false).description,
      backdropPath: widget.backdropPoster,
    );
    Provider.of<MovieStateProvider>(context, listen: false)
        .saveDurationForCurrentMovie(duration);
    print("The position where user left is ${duration.inSeconds}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SizedBox(
              child: _embedInfo == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : VdoPlayer(
                      embedInfo: EmbedInfo.streaming(
                          otp: _embedInfo!.otp!,
                          playbackInfo: _embedInfo!.playbackInfo!,
                          embedInfoOptions: EmbedInfoOptions(
                            resumePosition: widget.duration,
                          )),
                      onPlayerCreated: (controller) {
                        _onPlayerCreated(controller);
                      },
                      onFullscreenChange: _onFullscreenChange,
                      onError: _onVdoError,
                    ),
              width: MediaQuery.of(context).size.width,
              height: _isFullScreen.value
                  ? MediaQuery.of(context).size.height
                  : _getHeightForWidth(MediaQuery.of(context).size.width),
            ),
          ),
        ],
      ),
    );
  }

  _onVdoError(VdoError vdoError) {
    print("Oops, the system encountered a problem: " + vdoError.message);
    // Navigator.pop(context);
  }

  _onPlayerCreated(VdoPlayerController? controller) {
    setState(() {
      _controller = controller;
      _onEventChange(_controller);
    });
  }

  _onEventChange(VdoPlayerController? controller) {
    print("Event Change Was Called");
    _controller!.addListener(() {
      savePosition();
    });
  }

  _onFullscreenChange(isFullscreen) {
    print("Status of Screen : $isFullscreen");
    setState(() {
      _isFullScreen.value = true;
    });
  }

  double _getHeightForWidth(double width) {
    return width / aspectRatio;
  }

  EmbedInfo? _embedInfo;

  Future startStreaming() async {
    EmbedInfo embedInfo = await StreamingVideo().startSecureStreaming();
    _embedInfo = embedInfo;
    setState(() {});
  }
}
