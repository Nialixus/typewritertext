import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

class TypeWriter extends StatefulWidget {
  const TypeWriter({
    super.key,
    this.controller,
  }) : _text = controller.text;

  factory TypeWriter.text(text, {Key? key}) {
    return TypeWriter(
      key: key,
    );
  }

  final String _text;
  final TypeWriterController? controller;

  @override
  State<TypeWriter> createState() => _X();
}

class _X extends State<TypeWriter> {
  late TypeWriterController controller;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
