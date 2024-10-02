import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PermissionHandler {
  static Future<Directory?> requestDownloadsDirectory() async {
    return await getExternalStorageDirectory();
  }
}
