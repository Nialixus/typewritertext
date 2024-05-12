/// [TypeWriterText]'s library.
library typewritertext;

import 'dart:async';
import 'package:flutter/material.dart';

part 'v3/typewriter_controller.dart';
part 'v3/typewriter_value.dart';
part 'v3/typewriter.dart';

/// Enum to represent the type of [TypeWriterText].
enum _TypeWriterTextType {
  /// Represents a [TypeWriterText] with [Text] content.
  _text,

  /// Represents a [TypeWriterText] with a custom builder function.
  _builder,
}

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
    super.key,
    this.alignment,
    this.maintainSize = true,
    this.repeat = false,
    this.play = true,
    this.onFinished,
    required this.text,
    required this.duration,
  })  : _type = _TypeWriterTextType._text,
        builder = null,
        data = '',
        assert(onFinished == null || !repeat && play,
            'Cannot have onFinished when ${repeat ? '[repeat] is `true`.' : '[play] is `false`.'}');

  /// Constructor for creating a [TypeWriterText] with a custom builder function.
  ///
  /// The typewriter animation will be based on the provided [builder] function,
  /// which is called on each tick to generate the text to display.
  ///
  /// [data] is the text that will be displayed during the typewriter animation.
  /// [repeat] specifies whether the animation should repeat once completed (default is `false`).
  /// [play] determines whether the animation should start immediately (default is `true`).
  /// [duration] defines the time interval between each tick.
  /// [builder] is a function that generates the text to display based on the current tick.
  /// [onFinished] is a callback that is called when the animation is finished.
  ///
  /// Example usage:
  /// ```dart
  /// const TypeWriterText.builder(
  ///   "Your text",
  ///   duration: Duration(milliseconds: 50),
  ///   builder: (context, value) {
  ///     return AutoSizeText(
  ///       value,
  ///       textAlign: TextAlign.left,
  ///       style: Theme.of(context).textTheme.titleMedium,
  ///     );
  ///   },
  /// );
  /// ```
  const TypeWriterText.builder(
    this.data, {
    super.key,
    this.repeat = false,
    this.play = true,
    this.onFinished,
    required this.duration,
    required this.builder,
  })  : _type = _TypeWriterTextType._builder,
        text = null,
        alignment = null,
        maintainSize = false,
        assert(onFinished == null || !repeat && play,
            'Cannot have onFinished when ${repeat ? '[repeat] is `true`.' : '[play] is `false`.'}');

  /// Callback for when the animation is finished.
  final void Function(String value)? onFinished;

  /// The text data to be displayed during the typewriter animation.
  final String data;

  /// Widget builder for advance customization.
  final Widget Function(BuildContext context, String value)? builder;

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
  final bool play;

  @override
  State<TypeWriterText> createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
    );

    if (widget.play) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _run(context).then((_) {
          if (widget.onFinished != null) {
            switch (widget._type) {
              case _TypeWriterTextType._text:
                widget.onFinished!(
                  widget.text?.data?.substring(0, _tick) ?? '',
                );
                break;
              case _TypeWriterTextType._builder:
                widget.onFinished!(widget.data.substring(0, _tick));
                break;
            }
          }
        });
      });
    }
  }

  Future<void> _run(BuildContext context) async {
    if (_tick <
        (widget._type == _TypeWriterTextType._text
            ? widget.text!.data!.length
            : widget.data.length)) {
      await Future.delayed(widget.duration);
      if(!context.mounted)return;
      setState(() => _tick++);
      await _run(context);
    } else {
      if (widget.repeat) {
        await Future.delayed(widget.duration);
        if(!context.mounted)return;
        setState(() => _tick = 0);
        await _run(context);
      } else {
        return;
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
    switch (widget._type) {
      case _TypeWriterTextType._builder:
        return widget.builder!(context,
            widget.play ? widget.data.substring(0, _tick) : widget.data);
      case _TypeWriterTextType._text:
        if (!widget.play) {
          // If play is `false`, return original [Text] or [Builder].
          return widget.text!;
        } else {
          ///If play is `true`, return animated text.
          return LayoutBuilder(
            builder: (_, constraints) {
              final text = widget.text!;

              ///Used as a dummy final text so we can get the final width and height.
              TextPainter textPainter = TextPainter(
                  locale: text.locale,
                  maxLines: text.maxLines,
                  strutStyle: text.strutStyle,
                  text: TextSpan(
                      text: text.data!,
                      style: text.style,
                      locale: text.locale,
                      semanticsLabel: text.semanticsLabel),
                  textAlign: text.textAlign ?? TextAlign.start,
                  textDirection: text.textDirection ?? TextDirection.ltr,
                  textHeightBehavior: text.textHeightBehavior,
                  textWidthBasis: text.textWidthBasis ?? TextWidthBasis.parent)
                ..layout(
                    maxWidth: constraints.maxWidth,
                    minWidth: constraints.minWidth);

              return Container(
                alignment: widget.alignment,
                width: widget.maintainSize ? textPainter.width : null,
                height: widget.maintainSize ? textPainter.height : null,
                child: Text(
                  text.data!.substring(0, _tick),
                  selectionColor: text.selectionColor,
                  key: text.key,
                  locale: text.locale,
                  maxLines: text.maxLines,
                  overflow: text.overflow,
                  semanticsLabel: text.semanticsLabel,
                  softWrap: text.softWrap,
                  strutStyle: text.strutStyle,
                  style: text.style,
                  textAlign: text.textAlign,
                  textDirection: text.textDirection,
                  textHeightBehavior: text.textHeightBehavior,
                  textWidthBasis: text.textWidthBasis,
                ),
              );
            },
          );
        }
    }
  }
}
