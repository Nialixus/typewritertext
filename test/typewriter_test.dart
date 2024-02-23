import 'package:flutter_test/flutter_test.dart';
import 'package:typewritertext/typewritertext.dart';

void main() {
  group('TypeWriterValue', () {
    final value = TypeWriterValue(
      ['the', 'hash', 'slinging', 'slasher'],
      index: 2,
    );
    test('length', () {
      expect(value.length, equals(22));
      value.data = ['dummy'];
      expect(value.length, equals(5));
    });

    test('text', () {
      value.data = ['the', 'hash', 'slinging', 'slasher'];
      expect(value.text, equals('th'));
      value.index = 22;
      expect(value.text, equals('slasher'));
      value.index = 25;
      expect(value.text, equals('th'));
    });
  });
}
