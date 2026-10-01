import 'package:drift/wasm.dart';

// Compiled to web/drift_worker.js with:
//   dart compile js -O4 web/drift_worker.dart -o web/drift_worker.js
void main() => WasmDatabase.workerMainForOpen();
