///Library for [TypeWriterText].
///
///Uses to make typewriter animation text.
library typewritertext;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/typewritertextstate.dart';

export 'package:typewritertext/typewritertext.dart' show TypeWriterText;

///A simple typewriter text animation wrapper for flutter.
class TypeWriterText extends StatelessWidget {
  ///Create a wrapper widget to animate [Text] with typewriter animation.
  ///
  ///```dart
  ///const TypeWriterText(
  ///   text: Text("your text"),
  ///   duration: Duration(milliseconds:50),
  /// );
  ///```
  const TypeWriterText(
      {Key? key,
      required this.text,
      required this.duration,
      this.alignment,
      this.maintainSize = true,
      this.play = true})
      : super(key: key);

  ///Uses [Text] widget as it's value.
  final Text text;

  ///Uses [Duration] to define how fast text changes.
  final Duration duration;

  ///Align the text within the occupied size.
  final Alignment? alignment;

  ///To maintain occupied size of final text while animation played.
  ///
  ///Default value is `true`.
  final bool? maintainSize;

  ///To set whether animation should play or not.
  ///
  ///Default value is `true`.
  final bool? play;

  @override
  Widget build(BuildContext context) {
    if (play == false) {
      ///If play is `false`, return original [Text].
      return text;
    } else {
      ///If play is `true`, return animated text.
      return ChangeNotifierProvider<TypeWriterTextState>(
          create: (context) => TypeWriterTextState(text: text),
          builder: (animatedContext, animatedChild) {
            animatedContext.read<TypeWriterTextState>().animate(duration);
            return animatedChild!;
          },
          child: LayoutBuilder(builder: (_, constraints) {
            ///Uses as a dummy final text so we can get the final width and height.
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
                textScaleFactor: text.textScaleFactor ?? 1.0,
                textWidthBasis: text.textWidthBasis ?? TextWidthBasis.parent)
              ..layout(
                  maxWidth: constraints.maxWidth,
                  minWidth: constraints.minWidth);

            ///Uses to set `width`, `height` and `alignment`.
            return Container(
                alignment: alignment,
                width: maintainSize == true ? textPainter.width : null,
                height: maintainSize == true ? textPainter.height : null,
                child: Consumer<TypeWriterTextState>(
                    builder: (_, value, ___) => Text(
                          value.textContent,
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
                          textScaleFactor: text.textScaleFactor,
                          textWidthBasis: text.textWidthBasis,
                        )));
          }));
    }
  }
}
