import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/widgets.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import 'check_in_screen.dart';
import 'experience_calc.dart';
import 'look_back_screen.dart';
import 'remembered_rating_screen.dart';

/// Live view of an experience. For a finished experience without a remembered
/// rating it shows no check-in data.
class ExperienceScreen extends ConsumerWidget {
  const ExperienceScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = ref.watch(experienceProvider(id)).value;
    if (e == null) return Scaffold(appBar: AppBar());
    return Scaffold(
      appBar: AppBar(title: Text(e.name)),
      body: e.status == 'active'
          ? _Active(experience: e)
          : _Finished(experience: e),
    );
  }
}

class _Active extends ConsumerWidget {
  const _Active({required this.experience});
  final Experience experience;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = experience;
    final checkIns = ref.watch(checkInsProvider(e.id)).value ?? const [];
    final people = ref.watch(participantsProvider(e.id)).value ?? const [];
    final names = {for (final p in people) p.id: p.displayName};
    final fmt = DateFormat('EEE d MMM, HH:mm');
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Started ${e.startDate}'
          '${e.endDate != null ? ' · expected end ${e.endDate}' : ''} · '
          '${frequencies[e.checkinFrequency]}',
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          icon: const Icon(Icons.add_task),
          label: const Text('Check in'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CheckInScreen(experienceId: e.id),
            ),
          ),
        ),
        SectionHeader(
          'Participants',
          trailing: TextButton(
            onPressed: () async {
              final name = await promptText(context, 'Add person');
              if (name != null) {
                await ref
                    .read(experienceRepoProvider)
                    .addParticipant(e.id, name);
              }
            },
            child: const Text('Add person'),
          ),
        ),
        if (people.isEmpty) const EmptyLine('Just you'),
        for (final p in people) Text(p.displayName),
        const SectionHeader('Check-ins'),
        if (checkIns.isEmpty) const EmptyLine('No check-ins yet'),
        for (final c in checkIns.reversed)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '${c.rating} ${ratingLabels[c.rating]}'
              '${c.participantId != null ? ' · ${names[c.participantId] ?? ''}' : ''}'
              '${c.marker != 'none' ? ' · ${markers[c.marker]}' : ''}',
            ),
            subtitle: Text(
              '${fmt.format(c.checkedAt)}${c.note != null ? '\n${c.note}' : ''}',
            ),
            isThreeLine: c.note != null,
            trailing: IconButton(
              tooltip: 'Delete check-in',
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                if (await confirm(
                  context,
                  'Delete this check-in?',
                  action: 'Delete',
                )) {
                  await ref.read(experienceRepoProvider).deleteCheckIn(c.id);
                }
              },
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CheckInScreen(experienceId: e.id, editing: c),
              ),
            ),
          ),
        if (checkIns.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LookBackScreen(id: e.id)),
              ),
              child: const Text('View progress so far'),
            ),
          ),
        const Divider(height: 32),
        OutlinedButton(
          onPressed: () => _finish(context, ref),
          child: const Text('Mark as finished'),
        ),
      ],
    );
  }

  Future<void> _finish(BuildContext context, WidgetRef ref) async {
    var days = defaultRememberAfterDays;
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, setState) => AlertDialog(
          title: const Text('Mark as finished'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'After a wait, you will be asked to rate the whole experience '
                'from memory. Check-ins stay hidden until you answer.',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: days,
                decoration: const InputDecoration(labelText: 'Ask me after'),
                items: [
                  for (final d in rememberAfterChoices)
                    DropdownMenuItem(
                      value: d,
                      child: Text(
                        d == 0 ? 'Right away' : '$d day${d == 1 ? '' : 's'}',
                      ),
                    ),
                ],
                onChanged: (v) => setState(() => days = v ?? days),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Finish'),
            ),
          ],
        ),
      ),
    );
    if (ok == true) {
      await ref
          .read(experienceRepoProvider)
          .finish(experience.id, rememberAfterDays: days);
    }
  }
}

class _Finished extends ConsumerWidget {
  const _Finished({required this.experience});
  final Experience experience;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = experience;
    if (e.rememberedRating != null) {
      return Center(
        child: FilledButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LookBackScreen(id: e.id)),
          ),
          child: const Text('Open look back'),
        ),
      );
    }
    final due = isRememberedDue(e, DateTime.now());
    final unlock = rememberedUnlockAt(e);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Finished', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          due
              ? 'Time to rate it from memory.'
              : 'You will be asked to rate it from memory on '
                    '${DateFormat('d MMM yyyy').format(unlock!)}. '
                    'Your check-ins stay hidden until you answer.',
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => RememberedRatingScreen(id: e.id)),
          ),
          child: Text(due ? 'Rate it now' : 'Rate it now instead of waiting'),
        ),
      ],
    );
  }
}
