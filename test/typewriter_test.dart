import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:typewritertext/typewritertext.dart';

void main() {
  const data = 'Hello World';
  const duration = Duration(milliseconds: 50);

  late TypeWriterController controller;

  setUp(() {
    controller = TypeWriterController(
      text: data,
      duration: duration,
    );
  });

  tearDown(() {
    controller.dispose();
  });

  group('TypeWriter', () {
    testWidgets('text', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: TypeWriter(
              controller: controller,
              builder: (context, value) => Text(value.text),
              onFinished: (value) {
                expect(value.text, equals('Hello World'));
                expect(value.index, equals(10));
              },
            ),
          ),
        );

        await controller.start();
        await tester.pump();
        expect(find.text('Hello World'), findsOneWidget);
        expect(controller.value.text, equals('Hello World'));
      });
    });

    testWidgets('value', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: TypeWriter.text(
              'Hello World',
              duration: const Duration(milliseconds: 50),
              onChanged: (value) {
                final text = [
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
                ][value.index];

                expect(value.text, equals(text));
                expect(value.index <= 10, isTrue);
              },
            ),
          ),
        );
      });
    });
  });

  group('TypeWriterText', () {
    testWidgets('text', (WidgetTester tester) async {
      final widget = TypeWriterText(
        text: const Text(data),
        duration: duration,
        onFinished: (value) {},
      );
      await tester.pumpWidget(
        MaterialApp(home: widget),
      );
      await tester.pump(duration * data.length);
      expect(widget.onFinished != null, isTrue);
      expect(widget.onFinished, isA<void Function(String value)>());
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('builder', (tester) async {
      final widget = TypeWriterText.builder(
        data,
        duration: duration,
        builder: (context, value) => Text(value),
        onFinished: (value) {},
      );

      await tester.pumpWidget(
        MaterialApp(home: widget),
      );
      await tester.pump(duration * data.length);
      expect(widget.onFinished != null, isTrue);
      expect(widget.onFinished, isA<void Function(String value)>());
      expect(find.text('Hello World'), findsOneWidget);
    });
  });
}
