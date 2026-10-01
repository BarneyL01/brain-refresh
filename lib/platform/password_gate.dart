import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers.dart';

/// SHA-256 hex of the web password, compiled in with
/// `--dart-define=GATE_HASH=<hex>`. Empty disables the gate.
/// Keeps casual visitors out only; anyone reading the source can bypass it.
const _gateHash = String.fromEnvironment('GATE_HASH');
const _prefKey = 'gatePassed';

String hashPassword(String password) => sha256.convert(utf8.encode(password)).toString();

/// Web only. Android builds and builds without GATE_HASH show [child] directly.
class PasswordGate extends ConsumerStatefulWidget {
  const PasswordGate({super.key, required this.child});
  final Widget child;
  @override
  ConsumerState<PasswordGate> createState() => _PasswordGateState();
}

class _PasswordGateState extends ConsumerState<PasswordGate> {
  final _controller = TextEditingController();
  bool _wrong = false;

  bool get _enabled => kIsWeb && _gateHash.isNotEmpty;

  bool get _passed => ref.read(prefsProvider).getString(_prefKey) == _gateHash;

  void _submit() {
    if (hashPassword(_controller.text) == _gateHash) {
      ref.read(prefsProvider).setString(_prefKey, _gateHash);
      setState(() => _wrong = false);
    } else {
      setState(() => _wrong = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_enabled || _passed) return widget.child;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                controller: _controller,
                obscureText: true,
                autofocus: true,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _wrong ? 'Incorrect password' : null,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: _submit, child: const Text('Enter')),
            ]),
          ),
        ),
      ),
    );
  }
}
