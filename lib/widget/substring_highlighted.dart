import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class SubstringHighlight extends StatelessWidget {
  final String text;
  final List<String> terms;
  final TextStyle textStyle;
  final TextStyle textStyleHighlight;

  SubstringHighlight({
    @required this.text,
    @required this.terms,
    this.textStyle = const TextStyle(
      color: Colors.black,
    ),
    this.textStyleHighlight = const TextStyle(
      color: Colors.red,
    ),
  });

  @override
  Widget build(BuildContext context) {
    if (terms.isEmpty) {
      return Text(text, style: textStyle);
    } else {
      final matchingTerms =
          terms.where((term) => text.toLowerCase().contains(term)).toList();
      if (matchingTerms.isEmpty) return Text(text, style: textStyle);
      final termMatch = matchingTerms.first;
      final termLC = termMatch.toLowerCase();

      final List<InlineSpan> children = [];

      final List<String> spanList = text.toLowerCase().split(termLC);
      int i = 0;
      spanList.forEach((v) {
        if (v.isNotEmpty) {
          children.add(TextSpan(
              text: text.substring(i, i + v.length), style: textStyle));
          i += v.length;
        }
        if (i < text.length) {
          children.add(TextSpan(
              text: text.substring(i, i + termMatch.length),
              style: textStyleHighlight));
          i += termMatch.length;
        }
      });
      return RichText(text: TextSpan(children: children));
    }
  }
}
