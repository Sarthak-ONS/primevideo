import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerAPi {
  static checkPermissionStatus() async {
    PermissionStatus _permissionStatus = await Permission.storage.request();

    print(_permissionStatus);
    if (_permissionStatus.isGranted) {
      return true;
    }

    if (_permissionStatus.isDenied) {
      Permission.storage.request();
      return;
    }
  }
}
