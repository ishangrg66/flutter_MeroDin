import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepali_utils/nepali_utils.dart';

class NepaliUnicodeTextField extends StatefulWidget {
  const NepaliUnicodeTextField({super.key});

  @override
  State<NepaliUnicodeTextField> createState() => _NepaliUnicodeTextFieldState();
}

class _NepaliUnicodeTextFieldState extends State<NepaliUnicodeTextField> {
  final TextEditingController _controller = TextEditingController();
  String _display = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    final text = _controller.text;
    final parts = _splitKeepDelimiter(text);
    if (parts.isEmpty) {
      setState(() => _display = '');
      return;
    }

    int lastWordIndex = -1;
    for (int i = parts.length - 1; i >= 0; i--) {
      if (!_isWhitespaceOrPunct(parts[i])) {
        lastWordIndex = i;
        break;
      }
    }

    if (lastWordIndex == -1) {
      setState(() => _display = text);
      return;
    }

    parts[lastWordIndex] = NepaliUnicode.convert(parts[lastWordIndex]);
    setState(() => _display = parts.join());
  }

  List<String> _splitKeepDelimiter(String input) {
    final regex = RegExp(r'(\s+|[.,!?;:\-()\[\]"])', multiLine: true);
    final parts = <String>[];
    int start = 0;
    for (final match in regex.allMatches(input)) {
      if (match.start > start) parts.add(input.substring(start, match.start));
      parts.add(match.group(0)!);
      start = match.end;
    }
    if (start < input.length) parts.add(input.substring(start));
    return parts;
  }

  bool _isWhitespaceOrPunct(String s) {
    return RegExp(r'^(\s+|[.,!?;:\-()\[\]"])$').hasMatch(s);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Type Romanized Nepali (offline):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Type here: naya kam garne ...'),
            autofocus: true,
            maxLines: null,
          ),
          const SizedBox(height: 16),
          const Text('Live Conversion:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
            ),
            child: SelectableText(_display, style: const TextStyle(fontSize: 20, height: 1.4, fontFamily: 'NotoSansDevanagari')),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  if (_display.isEmpty) return;
                  await Clipboard.setData(ClipboardData(text: _display));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied')));
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  _controller.clear();
                  setState(() => _display = '');
                },
                icon: const Icon(Icons.clear),
                label: const Text('Clear'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}