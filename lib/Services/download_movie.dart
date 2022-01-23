import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prime_video/Services/permission_handler_api.dart';

final _videos = [
  {
    'name': 'Big Buck Bunny',
    'link':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
  },
  {
    'name': 'Elephant Dream',
    'link':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
  }
];

class DownloadApi {
  Future downloadAMovie({
    String? downloadMovieName,
    String? downloadMovieID,
  }) async {
    try {
      //   Directory directory = await getApplicationDocumentsDirectory();

      PermissionHandlerAPi.checkPermissionStatus();

      Directory appDocDirectory = await getApplicationDocumentsDirectory();

      String directoryPath = appDocDirectory.path + '/Movies';
      await Directory(directoryPath).create(recursive: true);
      Directory.fromUri(Uri(path: directoryPath)).existsSync();
      print(directoryPath);

      final taskId = await FlutterDownloader.enqueue(
        url: _videos[0]['link']!,
        savedDir:
            '$directoryPath/Movies/$downloadMovieID/${_videos[0]['name']!}',
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );

      //print(taskId);
    } catch (e) {
      print(e);
    }
  }
}
