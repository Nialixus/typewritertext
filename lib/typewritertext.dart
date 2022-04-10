///Library for [TypeWriterText].
library typewritertext;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///A simple typewriter text animation for flutter.
class TypeWriterText extends StatelessWidget {
  ///Create a widget to animate [Text] with typewriter animation.
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
      this.maintainSize,
      this.play})
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
    if (play ?? true == false) {
      ///If play is `false`, return original [Text].
      return text;
    } else {
      ///If play is `true`, return animated text.
      return ChangeNotifierProvider<TypeWriterTextState>.value(
          value: TypeWriterTextState(text: text),
          builder: (animatedContext, animatedChild) {
            ///Calling animate on `build()`.
            Provider.of<TypeWriterTextState>(animatedContext, listen: false)
                .animate(duration);

            ///Using [LayoutBuilder] to measure final occupied size of [Text].
            return LayoutBuilder(builder: (builderContext, builderConstraints) {
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
                    maxWidth: builderConstraints.maxWidth,
                    minWidth: builderConstraints.minWidth);

              ///Uses to set `width`, `height` and `alignment`.
              return Container(
                  alignment: alignment,
                  width:
                      (maintainSize ?? true) == true ? textPainter.width : null,
                  height: (maintainSize ?? true) == true
                      ? textPainter.height
                      : null,
                  child: Consumer<TypeWriterTextState>(
                      builder: (context, value, child) => Text(
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
            });
          });
    }
  }
}

///State Manager of [TypeWriterText].
class TypeWriterTextState with ChangeNotifier {
  ///A state that get [Text] from [TypeWriterText].
  TypeWriterTextState({required this.text});

  ///[Text] that pass from [TypeWriterText].
  final Text text;

  ///A generated list of [String] from [text].
  late List<String> textList = [
    for (int x = 0; x < text.data!.characters.length; x++)
      text.data!.characters.string.substring(0, x + 1)
  ];

  ///[String] that displayed in [TypeWriterText] animation.
  String textContent = '';

  ///A void function to start typewriting animation.
  void animate(Duration duration) async {
    ///Set the first displayed [String] from [textList].
    textContent = textList[0];

    ///Setting the displayed [String] from time to time.
    Timer.periodic(duration, (timer) {
      if (timer.tick >= textList.length) {
        ///End the animation.
        timer.cancel();
      } else {
        ///Set the rest [String] from [textList] to be displayed.
        textContent = textList[timer.tick];
        notifyListeners();
      }
    });
  }
}
