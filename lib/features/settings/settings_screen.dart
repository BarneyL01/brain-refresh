import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dates.dart';
import '../../core/widgets.dart';
import '../../data/backup_repository.dart';
import '../../data/providers.dart';
import '../../platform/backup_export.dart';
import '../../platform/backup_import.dart';
import 'tags_screen.dart';
import 'winddown_editor_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? _lastExport;

  @override
  void initState() {
    super.initState();
    _lastExport = lastExport(ref.read(prefsProvider));
  }

  String get _filename => 'brain-refresh-backup-${ymd(DateTime.now())}.json';

  Future<void> _export() async {
    final json = await ref.read(backupRepoProvider).exportJson();
    await deliverBackup(_filename, json);
    final now = DateTime.now();
    await setLastExport(ref.read(prefsProvider), now);
    if (mounted) setState(() => _lastExport = now.toIso8601String());
  }

  Future<void> _import() async {
    final repo = ref.read(backupRepoProvider);
    final text = await pickBackupText();
    if (text == null || !mounted) return;
    final BackupSummary summary;
    try {
      summary = repo.summarize(text);
    } on BackupException catch (e) {
      showMessage(context, e.message);
      return;
    }
    final lines = summary.counts.entries.where((e) => e.value > 0).map((e) => '${e.key}: ${e.value}');
    final ok = await confirm(
      context,
      'Exported ${ymd(summary.exportedAt)}.\n\n${lines.join('\n')}\n\n'
      'This replaces all current data. Your current data is exported first.',
      action: 'Replace data',
    );
    if (!ok || !mounted) return;
    // Safety copy of the current data before replacing it.
    await deliverBackup('brain-refresh-before-import-${ymd(DateTime.now())}.json',
        await repo.exportJson());
    await repo.import(text);
    if (mounted) showMessage(context, 'Backup restored');
  }

  @override
  Widget build(BuildContext context) {
    final last = _lastExport == null ? 'never' : ymd(DateTime.parse(_lastExport!));
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: [
        const Padding(padding: EdgeInsets.fromLTRB(16, 16, 16, 0), child: SectionHeader('Backup')),
        ListTile(
          leading: const Icon(Icons.upload),
          title: const Text('Export backup'),
          subtitle: Text('Last export: $last'),
          onTap: _export,
        ),
        ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Import backup'),
          subtitle: const Text('Replaces all current data'),
          onTap: _import,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.nightlight),
          title: const Text('Wind-down routine'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const WinddownEditorScreen())),
        ),
        ListTile(
          leading: const Icon(Icons.label),
          title: const Text('Tags'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TagsScreen())),
        ),
      ]),
    );
  }
}
