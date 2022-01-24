import 'package:flutter/material.dart';
import 'package:prime_video/Services/movie_streaming.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

class VdoPlaybackView extends StatefulWidget {
  const VdoPlaybackView({Key? key}) : super(key: key);

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

  Future savePosition() async {
    Duration duration = await _controller!.getPosition();
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
                      embedInfo: _embedInfo!,
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
