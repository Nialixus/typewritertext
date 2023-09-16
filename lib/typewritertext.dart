/// [TypeWriterText]'s library.
library typewritertext;

import 'dart:async';
import 'package:flutter/material.dart';

enum _TypeWriterTextType { text, builder }

/// A simple typewriter text animation wrapper for flutter.
class TypeWriterText extends StatefulWidget {
  /// Create a wrapper widget to animate [Text] with typewriter animation.
  ///
  ///```dart
  ///const TypeWriterText(
  ///   text: Text("your text"),
  ///   duration: Duration(milliseconds:50),
  /// );
  ///```
  const TypeWriterText({
    Key? key,
    required this.text,
    required this.duration,
    this.alignment,
    this.maintainSize = true,
    this.repeat = false,
    this.play = true,
  })  : _type = _TypeWriterTextType.text,
        builder = null,
        super(key: key);

  const TypeWriterText.builder({
    Key? key,
    this.alignment,
    this.maintainSize = true,
    this.repeat = false,
    this.play = true,
    required this.duration,
    required this.builder,
  })  : _type = _TypeWriterTextType.builder,
        text = null,
        super(key: key);

  /// Widget builder for advance customization.
  final Widget Function(BuildContext context)? builder;

  /// Requires [Text] widget as it's value.
  final Text? text;

  /// A private identifier bet
  // ignore: unused_field
  final _TypeWriterTextType _type;

  ///Repeat animation.
  ///
  ///Default value is `false`.
  final bool repeat;

  ///Define how fast text changes.
  final Duration duration;

  ///Align the text within the occupied size.
  final Alignment? alignment;

  ///To maintain occupied size of final text while animation played.
  ///
  ///Default value is `true`.
  final bool maintainSize;

  ///To set whether animation should be played or not.
  ///
  ///Default value is `true`.
  final bool? play;

  @override
  State<TypeWriterText> createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _textContent = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
    );

    if (widget.play == true) {
      _startTyping(0);
    }
  }

  void _startTyping(int index) {
    if (index < widget.text.data!.length) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          setState(() {
            _textContent += widget.text.data![index];
          });
          _startTyping(index + 1);
        }
      });
    } else {
      if (widget.repeat) {
        Future.delayed(widget.duration, () {
          if (mounted) {
            setState(() {
              _textContent = "";
            });
            _startTyping(0);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.play == false) {
      ///If play is `false`, return original [Text].
      return widget.text;
    } else {
      ///If play is `true`, return animated text.
      return LayoutBuilder(builder: (_, constraints) {
        ///Used as a dummy final text so we can get the final width and height.
        TextPainter textPainter = TextPainter(
            locale: widget.text.locale,
            maxLines: widget.text.maxLines,
            strutStyle: widget.text.strutStyle,
            text: TextSpan(
                text: widget.text.data!,
                style: widget.text.style,
                locale: widget.text.locale,
                semanticsLabel: widget.text.semanticsLabel),
            textAlign: widget.text.textAlign ?? TextAlign.start,
            textDirection: widget.text.textDirection ?? TextDirection.ltr,
            textHeightBehavior: widget.text.textHeightBehavior,
            textScaleFactor: widget.text.textScaleFactor ?? 1.0,
            textWidthBasis: widget.text.textWidthBasis ?? TextWidthBasis.parent)
          ..layout(maxWidth: constraints.maxWidth, minWidth: constraints.minWidth);

        return Container(
            alignment: widget.alignment,
            width: widget.maintainSize == true ? textPainter.width : null,
            height: widget.maintainSize == true ? textPainter.height : null,
            child: Text(
              _textContent,
              key: widget.text.key,
              locale: widget.text.locale,
              maxLines: widget.text.maxLines,
              overflow: widget.text.overflow,
              semanticsLabel: widget.text.semanticsLabel,
              softWrap: widget.text.softWrap,
              strutStyle: widget.text.strutStyle,
              style: widget.text.style,
              textAlign: widget.text.textAlign,
              textDirection: widget.text.textDirection,
              textHeightBehavior: widget.text.textHeightBehavior,
              textScaleFactor: widget.text.textScaleFactor,
              textWidthBasis: widget.text.textWidthBasis,
            ));
      });
    }
  }
}
