import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:typewritertext/typewritertext.dart';

void main() {
  group('TypeWriterController', () {
    late TypeWriterController controller;

    setUp(() {
      controller = TypeWriterController.fromValue(
        TypeWriterValue(['Hello ', 'World']),
        duration: const Duration(milliseconds: 50),
      );
    });

    tearDown(() {
      controller.dispose();
    });

    test('value', () async {
      controller.addListener(() {
        expect(
            controller.value.text,
            equals([
              'H',
              'He',
              'Hel',
              'Hell',
              'Hello',
              'Hello ',
              'W',
              'Wo',
              'Wor',
              'Worl',
              'World',
            ][controller.value.index]));

        expect(controller.value.index < 'Hello World'.length, isTrue);
      });

      await controller.start();

      expect(controller.value.index == 'Hello World'.length - 1, isTrue);
      expect(controller.value.text, equals('World'));

      await controller.resume();
      expect(controller.value.index == 'Hello World'.length - 1, isTrue);
      expect(controller.value.text, equals('World'));
    });
  });

  group('StreamController', () {
    late StreamController<String> streamer;
    late TypeWriterController controller;

    setUp(() {
      streamer = StreamController<String>();
      controller = TypeWriterController.fromStream(streamer.stream);
    });

    tearDown(() {
      streamer.close();
      controller.dispose();
    });

    test('value', () async {
      controller.addListener(() {
        expect(
            controller.value.text,
            equals([
              'H',
              'He',
              'Hel',
              'Hell',
              'Hello',
              'Hello ',
              'Hello W',
              'Hello Wo',
              'Hello Wor',
              'Hello Worl',
              'Hello World',
              'Hello World 🚀',
              'Hello World 🚀', // The emoji length counted as 2,
            ][controller.value.index]));

        expect(controller.value.index < 'Hello World 🚀'.runes.length, isTrue);
      });

      await Future.delayed(Duration.zero);
      expect(controller.value.index == ''.runes.length - 1, isTrue);
      expect(controller.value.text, equals(''));

      streamer.add("Hello ");
      await Future.delayed(Duration.zero);
      expect(controller.value.index == 'Hello '.runes.length - 1, isTrue);
      expect(controller.value.text, equals('Hello '));

      streamer.add("World 🚀");
      await Future.delayed(Duration.zero);
      expect(
        controller.value.index == 'Hello World 🚀'.runes.length - 1,
        isTrue,
      );
      expect(controller.value.text, equals('Hello World 🚀'));
    });
  });
}
