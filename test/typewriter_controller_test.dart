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

        expect(controller.value.index <= 'Hello World'.length, isTrue);
      });

      await controller.start();
    });
  });
}
