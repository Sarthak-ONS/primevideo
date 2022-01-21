import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flowder/flowder.dart';

class DownloadApi {
  Future downloadAMovie({
    String? downloadMovieName,
    String? downloadMovieID,
  }) async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
  }
}
