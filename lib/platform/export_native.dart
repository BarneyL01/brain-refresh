import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Android: writes the file to the temp directory and opens the share sheet.
Future<void> deliverBackup(String filename, String json) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$filename');
  await file.writeAsString(json);
  await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
}
