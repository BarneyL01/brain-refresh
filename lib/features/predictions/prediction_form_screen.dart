import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dates.dart';
import '../../core/rules.dart';
import '../../core/widgets.dart';
import '../../data/database.dart';
import '../../data/providers.dart';

class PredictionFormScreen extends ConsumerStatefulWidget {
  const PredictionFormScreen({super.key, this.existing});
  final Prediction? existing;
  @override
  ConsumerState<PredictionFormScreen> createState() => _PredictionFormScreenState();
}

class _PredictionFormScreenState extends ConsumerState<PredictionFormScreen> {
  final _form = GlobalKey<FormState>();
  late final _statement = TextEditingController(text: widget.existing?.statement);
  late int _confidence = widget.existing?.confidence ?? defaultConfidence;
  late String _resolveBy = widget.existing?.resolveBy ?? todayYmd();
  late int? _tagId = widget.existing?.tagId;

  bool get _locked =>
      widget.existing != null && isLocked(widget.existing!.createdAt, DateTime.now());

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final repo = ref.read(predictionRepoProvider);
    final e = widget.existing;
    if (e == null) {
      await repo.create(
        statement: _statement.text,
        confidence: _confidence,
        resolveBy: _resolveBy,
        tagId: _tagId,
      );
    } else {
      await repo.update(e.id,
          statement: _statement.text, tagId: _tagId, confidence: _confidence);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Edit prediction' : 'New prediction')),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          TextFormField(
            controller: _statement,
            minLines: 2,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Statement',
              helperText: 'Must be checkable as true or false on the resolve-by date',
            ),
            validator: (v) => (v ?? '').trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          ConfidenceField(
            value: _confidence,
            onChanged: _locked ? null : (v) => setState(() => _confidence = v),
            helper: _locked ? 'Locked 24 hours after creation' : null,
          ),
          const SizedBox(height: 16),
          if (!editing)
            DateField(
              label: 'Resolve-by date',
              value: _resolveBy,
              firstDate: DateTime.now(),
              onChanged: (v) => setState(() => _resolveBy = v),
            ),
          if (!editing) const SizedBox(height: 16),
          TagField(value: _tagId, onChanged: (v) => setState(() => _tagId = v)),
          const SizedBox(height: 24),
          FilledButton(onPressed: _save, child: const Text('Save')),
        ]),
      ),
    );
  }
}
