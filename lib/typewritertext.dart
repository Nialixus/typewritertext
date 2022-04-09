library typewritertext;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeWriterText extends StatelessWidget {
  const TypeWriterText(
      {Key? key,
      required this.text,
      required this.duration,
      this.play,
      this.maintainSize})
      : super(key: key);
  final Text text;
  final Duration duration;
  final bool? play;
  final bool? maintainSize;

  @override
  Widget build(BuildContext context) {
    return (play ?? true) == false
        ? text
        : ChangeNotifierProvider<TypeWriterTextState>.value(
            value: TypeWriterTextState(text: text),
            builder: (animatedContext, animatedChild) {
              Provider.of<TypeWriterTextState>(animatedContext, listen: false)
                  .animate(duration);

              return LayoutBuilder(
                  builder: (builderContext, builderConstraints) {
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
                    textWidthBasis:
                        text.textWidthBasis ?? TextWidthBasis.parent)
                  ..layout(
                      maxWidth: builderConstraints.maxWidth,
                      minWidth: builderConstraints.minWidth);

                return Container(
                    alignment: text.textAlign == TextAlign.center
                        ? Alignment.center
                        : text.textAlign == TextAlign.end
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    width: (maintainSize ?? true) == true
                        ? textPainter.width
                        : null,
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

class TypeWriterTextState with ChangeNotifier {
  TypeWriterTextState({required this.text});
  final Text text;

  late List<String> textList = [
    for (int x = 0; x < text.data!.characters.length; x++)
      text.data!.characters.string.substring(0, x + 1)
  ];

  String textContent = '';

  void animate(Duration duration) async {
    textContent = textList[0];

    Timer.periodic(duration, (timer) {
      if (timer.tick >= textList.length) {
        timer.cancel();
      } else {
        textContent = textList[timer.tick];
        notifyListeners();
      }
    });
  }
}
