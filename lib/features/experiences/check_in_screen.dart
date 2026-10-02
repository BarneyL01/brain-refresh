import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/widgets.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import 'experience_calc.dart';
import 'rating_buttons.dart';

/// One screen: 1-5 buttons (one row per person), optional note, optional marker.
/// Pass [editing] to change a single existing check-in instead.
class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key, required this.experienceId, this.editing});
  final int experienceId;
  final CheckIn? editing;
  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  late final _note = TextEditingController(text: widget.editing?.note);
  late String _marker = widget.editing?.marker ?? 'none';
  late DateTime _at = widget.editing?.checkedAt ?? DateTime.now();
  final _ratings = <int?, int>{};

  @override
  void initState() {
    super.initState();
    final e = widget.editing;
    if (e != null) _ratings[e.participantId] = e.rating;
  }

  Future<void> _pickTime() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _at,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (d == null || !mounted) return;
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_at),
    );
    if (t == null) return;
    setState(() => _at = DateTime(d.year, d.month, d.day, t.hour, t.minute));
  }

  Future<void> _save(List<ExperienceParticipant> people) async {
    final repo = ref.read(experienceRepoProvider);
    if (_ratings.isEmpty) {
      showMessage(context, 'Tap a rating from 1 to 5');
      return;
    }
    final e = widget.editing;
    if (e != null) {
      await repo.updateCheckIn(
        e.id,
        rating: _ratings[e.participantId]!,
        note: _note.text,
        marker: _marker,
        checkedAt: _at,
      );
    } else {
      // Main user first, then participants in order.
      final order = <int?>[null, ...people.map((p) => p.id)];
      await repo.addCheckIns(
        widget.experienceId,
        ratings: [
          for (final id in order)
            if (_ratings.containsKey(id))
              (participantId: id, rating: _ratings[id]!),
        ],
        note: _note.text,
        marker: _marker,
        at: _at,
      );
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final people =
        ref.watch(participantsProvider(widget.experienceId)).value ?? const [];
    final exp = ref.watch(experienceProvider(widget.experienceId)).value;
    final editing = widget.editing;
    final rows = editing != null
        ? [
            (
              id: editing.participantId,
              name: _nameFor(editing.participantId, people),
            ),
          ]
        : [
            (id: null as int?, name: 'Me'),
            for (final p in people) (id: p.id as int?, name: p.displayName),
          ];
    return Scaffold(
      appBar: AppBar(
        title: Text(editing != null ? 'Edit check-in' : 'Check in'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (exp != null)
            Text(exp.name, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final r in rows) ...[
            if (rows.length > 1)
              Text(r.name, style: Theme.of(context).textTheme.labelLarge),
            if (rows.length > 1) const SizedBox(height: 4),
            RatingButtons(
              value: _ratings[r.id],
              onChanged: (v) => setState(() => _ratings[r.id] = v),
            ),
            const SizedBox(height: 12),
          ],
          TextField(
            controller: _note,
            maxLength: checkInNoteMax,
            decoration: const InputDecoration(
              labelText: 'What happened? (optional)',
            ),
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: [
              for (final m in markers.entries)
                ButtonSegment(value: m.key, label: Text(m.value)),
            ],
            selected: {_marker},
            onSelectionChanged: (s) => setState(() => _marker = s.first),
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: Text(DateFormat('EEE d MMM, HH:mm').format(_at)),
            subtitle: const Text('Tap to change the time'),
            onTap: _pickTime,
          ),
          const SizedBox(height: 8),
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            onPressed: () => _save(people),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  String _nameFor(int? id, List<ExperienceParticipant> people) => id == null
      ? 'Me'
      : people.where((p) => p.id == id).firstOrNull?.displayName ?? 'Unknown';
}
