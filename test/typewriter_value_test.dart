import 'package:flutter_test/flutter_test.dart';
import 'package:typewritertext/v3/typewriter.dart';

void main() {
  group('TypeWriterValue', () {
    final value = TypeWriterValue(
      ['the', 'hash', 'slinging', 'slasher'],
      index: 2,
    );

    test('text', () {
      expect(value.text, equals('the'));
      value.index = 21;
      expect(value.text, equals('slasher'));
      value.index = 24;
      expect(value.text, equals('the'));
      expect(
          value.toString(),
          equals(
              'TypeWriterValue{data: [the, hash, slinging, slasher], text: the, index: 2}'));
    });
    test('length', () {
      expect(value.length, equals(22));
      value.data = ['dummy'];
      expect(value.length, equals(5));
    });
  });
}
