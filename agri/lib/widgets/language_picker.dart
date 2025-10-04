// widgets/language_picker.dart
import 'package:flutter/material.dart';

typedef LangChanged = void Function(String lang);

class LanguagePicker extends StatefulWidget {
  final String initial;
  final LangChanged onChanged;
  const LanguagePicker({
    Key? key,
    required this.initial,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  late String _selected;
  final List<String> _langs = [
    'English', 'हिंदी (Hindi)', 'ਪੰਜਾਬੀ (Punjabi)'
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _langs.length,
      itemBuilder: (_, i) => RadioListTile<String>(
        title: Row(children: [
          Image.asset('assets/images/Flag Image.png', width: 24),
          const SizedBox(width: 10),
          Text(_langs[i]),
        ]),
        value: _langs[i],
        groupValue: _selected,
        activeColor: Colors.black,
        onChanged: (v) {
          setState(() => _selected = v!);
          widget.onChanged(v!); // bubble up
        },
      ),
    );
  }
}
