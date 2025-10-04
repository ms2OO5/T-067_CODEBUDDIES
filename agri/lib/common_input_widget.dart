import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────────────────
/// A reusable first‑step screen: ask for the current value + password
/// title       – big title on AppBar
/// hint        – placeholder for the “current … ” text field
/// onNext()    – called with (currentValue, password) when user taps Next
/// ─────────────────────────────────────────────────────────────────────────
class EnterCurrent extends StatefulWidget {
  final String title;
  final String hint;
  final void Function(String current, String password) onNext;

  const EnterCurrent({
    Key? key,
    required this.title,
    required this.hint,
    required this.onNext,
  }) : super(key: key);

  @override
  State<EnterCurrent> createState() => _EnterCurrentState();
}

class _EnterCurrentState extends State<EnterCurrent> {
  final _currentCtrl = TextEditingController();
  final _pwdCtrl     = TextEditingController();
  bool   _obscure    = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _currentCtrl,
              decoration: InputDecoration(
                hintText: widget.hint,
                filled: true,
                fillColor: Colors.white,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pwdCtrl,
              obscureText: _obscure,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon:
                  Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
                filled: true,
                fillColor: Colors.white,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final v = _currentCtrl.text.trim();
                final p = _pwdCtrl.text.trim();
                if (v.isEmpty || p.isEmpty) return;
                widget.onNext(v, p);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black,
              ),
              child: const Text('Next', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
