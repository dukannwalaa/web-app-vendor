import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:vendor/utils/permission_handler.dart';
import 'package:vendor/utils/utility.dart';

class FileHandler {
  static Future openFile(File file) async {
    final url = file.path;
    try {
      var res = await OpenFile.open(url);
      kPrint(res.toString());
    } catch (e) {
      kPrint(e.toString());
    }
  }

  static Future<File> saveDocument({
    required String name,
    required dynamic data,
  }) async {
    try {
      final bytes = await data.save();

      final dir = await PermissionHandler.requestDownloadsDirectory();
      final file = File('${dir?.path}/$name');

      await file.writeAsBytes(bytes);

      return file;
    } catch (e) {
      kPrint(e.toString());
      return File('');
    }
  }
}
