import 'package:drift/drift.dart';

import 'database.dart';

class TagRepository {
  TagRepository(this.db);
  final AppDatabase db;

  Stream<List<Tag>> watchAll() =>
      (db.select(db.tags)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  Future<int> add(String name) =>
      db.into(db.tags).insert(TagsCompanion.insert(name: name.trim()));

  Future<void> rename(int id, String name) =>
      (db.update(db.tags)..where((t) => t.id.equals(id))).write(
        TagsCompanion(name: Value(name.trim()), updatedAt: Value(DateTime.now())),
      );

  Future<int> usageCount(int id) async {
    final p = await (db.select(db.predictions)..where((t) => t.tagId.equals(id))).get();
    final j = await (db.select(db.journalEntries)..where((t) => t.tagId.equals(id))).get();
    return p.length + j.length;
  }

  /// Deletes the tag only if nothing uses it. Returns whether it was deleted.
  Future<bool> deleteIfUnused(int id) async {
    if (await usageCount(id) > 0) return false;
    await (db.delete(db.tags)..where((t) => t.id.equals(id))).go();
    return true;
  }
}
