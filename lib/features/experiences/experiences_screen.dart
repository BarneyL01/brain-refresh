import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets.dart';
import '../../data/providers.dart';
import 'experience_form_screen.dart';
import 'navigation.dart';

class ExperiencesScreen extends ConsumerWidget {
  const ExperiencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(experiencesProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(title: const Text('Experiences')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New experience',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ExperienceFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
      body: list.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: EmptyLine('No experiences yet'),
            )
          : ListView(
              children: [
                for (final e in list)
                  ListTile(
                    title: Text(e.name),
                    subtitle: Text(
                      [
                        e.status == 'active' ? 'Active' : 'Finished',
                        'started ${e.startDate}',
                        if (e.rememberedRating != null)
                          'remembered ${e.rememberedRating}/5',
                      ].join(' · '),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => openExperience(context, e),
                  ),
              ],
            ),
    );
  }
}
