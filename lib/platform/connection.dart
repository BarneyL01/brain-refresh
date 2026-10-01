import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Opens the app database: native SQLite file on Android, WebAssembly in the
/// browser (needs web/sqlite3.wasm and web/drift_worker.js).
QueryExecutor openConnection() => driftDatabase(
      name: 'brain_refresh',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
