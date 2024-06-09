// ignore_for_file: deprecated_member_use_from_same_package

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
      TypeWriterText widget = TypeWriterText(
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

      widget = const TypeWriterText(
        text: Text(data),
        play: false,
        duration: duration,
      );
      await tester.pumpWidget(
        MaterialApp(home: widget),
      );
      expect(widget.onFinished == null, isTrue);
      expect(find.text('Hello World'), findsOneWidget);

      widget = const TypeWriterText(
        text: Text(data),
        duration: duration,
        repeat: true,
      );
      await tester.pumpWidget(MaterialApp(home: widget),
          duration: const Duration(seconds: 10));
      expect(find.text('Hello World'), findsOneWidget);

      expect(() async {
        widget = TypeWriterText(
          text: const Text(data),
          duration: duration,
          repeat: true,
          onFinished: (value) {},
        );

        await tester.pumpWidget(
          MaterialApp(home: widget),
        );
      }, throwsA(isA<AssertionError>()));

      expect(() async {
        widget = TypeWriterText(
          text: const Text(data),
          duration: duration,
          play: false,
          repeat: true,
          onFinished: (value) {},
        );

        await tester.pumpWidget(
          MaterialApp(home: widget),
        );
      }, throwsA(isA<AssertionError>()));
    });

    testWidgets('builder', (tester) async {
      TypeWriterText widget = TypeWriterText.builder(
        data,
        duration: duration,
        onFinished: (value) {},
        builder: (context, value) => Text(value),
      );

      await tester.pumpWidget(
        MaterialApp(home: widget),
      );
      await tester.pump(duration * data.length);
      expect(widget.onFinished != null, isTrue);
      expect(widget.onFinished, isA<void Function(String value)>());
      expect(find.text('Hello World'), findsOneWidget);

      widget = TypeWriterText.builder(
        data,
        play: false,
        duration: duration,
        builder: (context, value) => Text(value),
      );
      await tester.pumpWidget(
        MaterialApp(home: widget),
      );
      expect(widget.onFinished == null, isTrue);
      expect(find.text('Hello World'), findsOneWidget);

      expect(() async {
        widget = TypeWriterText.builder(
          data,
          duration: duration,
          repeat: true,
          onFinished: (value) {},
          builder: (context, value) => Text(value),
        );

        await tester.pumpWidget(
          MaterialApp(home: widget),
        );
      }, throwsA(isA<AssertionError>()));

      expect(() async {
        widget = TypeWriterText.builder(
          data,
          duration: duration,
          play: false,
          onFinished: (value) {},
          builder: (context, value) => Text(value),
        );

        await tester.pumpWidget(
          MaterialApp(home: widget),
        );
      }, throwsA(isA<AssertionError>()));
    });
  });
}
