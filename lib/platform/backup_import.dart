import 'dart:convert';

import 'package:file_picker/file_picker.dart';

/// Lets the user pick a backup file and returns its text, or null if cancelled.
Future<String?> pickBackupText() async {
  final files = await FilePicker.pickFiles(type: FileType.any);
  if (files.isEmpty) return null;
  return utf8.decode(await files.first.readAsBytes());
}
