import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis});

  final String text;
  final TextStyle style;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(text,
    maxLines: maxLines,
    softWrap: true,
    overflow: overflow,
    textAlign: TextAlign.left,
     style: style);
  }
}
