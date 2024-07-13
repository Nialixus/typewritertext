import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:typewritertext/typewritertext.dart';

class ChatGPTStreamMock extends Stream<String> {
  ChatGPTStreamMock({List<String>? message}) {
    chat(message: message);
  }

  final _controller = StreamController<String>();

  @override
  StreamSubscription<String> listen(
    void Function(String event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  Future<void> chat({List<String>? message}) async {
    int index = 0;
    List<String> response = message ?? ["Hello World"];

    if (response.isNotEmpty) _controller.add(response[index]);
    Timer.periodic(const Duration(milliseconds: 150), (_) {
      if (index + 1 < response.length) {
        index += 1;
        _controller.add(response[index]);
      }
    });
  }
}

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
    late TypeWriterController controller;

    setUp(() {
      controller = TypeWriterController.fromStream(ChatGPTStreamMock());
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
              'Hello W',
              'Hello Wo',
              'Hello Wor',
              'Hello Worl',
              'Hello World',
            ][controller.value.index]));

        expect(controller.value.index < 'Hello World'.length, isTrue);
      });

      await controller.start();

      expect(controller.value.index == 'Hello World'.length - 1, isTrue);
      expect(controller.value.text, equals('Hello World'));

      await controller.resume();
      expect(controller.value.index == 'Hello World'.length - 1, isTrue);
      expect(controller.value.text, equals('Hello World'));
    });
  });
}
