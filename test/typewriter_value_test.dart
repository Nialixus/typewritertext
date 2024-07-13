import 'package:flutter_test/flutter_test.dart';
import 'package:typewritertext/typewritertext.dart';

void main() {
  group('TypeWriterValue', () {
    final value = TypeWriterValue(
      ['the👑', 'hash', 'slinging', 'slasher'],
      index: 3,
    );

    test('text', () {
      expect(value.text, equals('the👑'));
      value.index = 22;
      expect(value.text, equals('slasher'));
      value.index = 25;
      expect(value.text, equals('the'));
      expect(
          value.toString(),
          equals(
              'TypeWriterValue{data: [the👑, hash, slinging, slasher], text: the, index: 2}'));
    });
    test('length', () {
      expect(value.length, equals(23));
      value.data = ['dummy'];
      expect(value.length, equals(5));
    });
  });
}
