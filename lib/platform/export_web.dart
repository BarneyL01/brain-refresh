import 'package:web/web.dart' as web;

/// Web: downloads the file through a temporary link.
Future<void> deliverBackup(String filename, String json) async {
  final href = 'data:application/json;charset=utf-8,${Uri.encodeComponent(json)}';
  final a = web.HTMLAnchorElement()
    ..href = href
    ..download = filename;
  web.document.body!.append(a);
  a.click();
  a.remove();
}
