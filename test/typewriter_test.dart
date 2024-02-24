import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:typewritertext/typewritertext.dart';

void main() {
  group('TypeWriter', () {
    testWidgets('text', (WidgetTester tester) async {
      final controller = TypeWriterController(
        text: 'Hello World',
        duration: const Duration(milliseconds: 50),
      );

      await tester.runAsync(() async {
        await controller.start();

        await tester.pumpWidget(
          MaterialApp(
            home: TypeWriter(
              controller: controller,
              builder: (context, value) => Text(value.text),
            ),
          ),
        );

        expect(find.text('Hello World'), findsOneWidget);
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
}
