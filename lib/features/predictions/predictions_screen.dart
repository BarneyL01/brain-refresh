import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets.dart';
import '../../data/prediction_repository.dart';
import '../../data/providers.dart';
import 'prediction_detail_screen.dart';
import 'prediction_form_screen.dart';

class PredictionsScreen extends ConsumerStatefulWidget {
  const PredictionsScreen({super.key});
  @override
  ConsumerState<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends ConsumerState<PredictionsScreen> {
  PredictionFilter _filter = PredictionFilter.open;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(predictionsByFilter(_filter));
    return Scaffold(
      appBar: AppBar(title: const Text('Predictions')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add prediction',
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const PredictionFormScreen())),
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: SegmentedButton<PredictionFilter>(
            segments: const [
              ButtonSegment(value: PredictionFilter.open, label: Text('Open')),
              ButtonSegment(value: PredictionFilter.due, label: Text('Due')),
              ButtonSegment(value: PredictionFilter.resolved, label: Text('Resolved')),
            ],
            selected: {_filter},
            onSelectionChanged: (s) => setState(() => _filter = s.first),
          ),
        ),
        Expanded(
          child: items.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (list) => list.isEmpty
                ? const Padding(padding: EdgeInsets.all(16), child: EmptyLine('Nothing here'))
                : ListView(children: [
                    for (final p in list) PredictionTile(prediction: p),
                  ]),
          ),
        ),
      ]),
    );
  }
}

class PredictionTile extends StatelessWidget {
  const PredictionTile({super.key, required this.prediction});
  final dynamic prediction;

  @override
  Widget build(BuildContext context) {
    final p = prediction;
    return ListTile(
      title: Text(p.statement as String),
      subtitle: Text('${p.confidence}% · resolve by ${p.resolveBy}'
          '${p.outcome != null ? ' · ${outcomeLabel(p.outcome as String?)}' : ''}'),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PredictionDetailScreen(id: p.id as int)),
      ),
    );
  }
}
