import 'dart:io';
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

      //print(taskId);
    } catch (e) {
      print(e);
    }
  }
}
