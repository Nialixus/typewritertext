import 'dart:async';
import 'package:flutter/material.dart';

export '../src/typewritertextstate.dart' hide TypeWriterTextState;

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

  ///A [String] that displayed in [TypeWriterText] animation.
  ///
  ///Default value is `''`.
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
