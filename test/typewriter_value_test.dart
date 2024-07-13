import 'package:flutter_test/flutter_test.dart';
import 'package:typewritertext/typewritertext.dart';

void main() {
  group('TypeWriterValue', () {
    var value = TypeWriterValue(
      ['the', 'hash', 'slinging', 'slasher'],
      index: 2,
    );

    test('text', () {
      expect(value.text, equals('the'));
      value.index = 21;
      expect(value.text, equals('slasher'));
      value.index = 24;
      expect(value.text, equals('the'));
      expect(value.length, equals(22));
      expect(
          value.toString(),
          equals('TypeWriterValue('
              'data: [the, hash, slinging, slasher], '
              'text: the, '
              'index: 2)'));
      value += ' 👑';
      expect(value.text, equals('thehashslingingslasher 👑'));
      expect(value.length, equals(24));
      expect(value.index, equals(23));
      expect(
          value.toString(),
          equals('TypeWriterValue('
              'data: [thehashslingingslasher 👑], '
              'text: thehashslingingslasher 👑, '
              'index: 23)'));
    });
    test('length', () {
      expect(value.length, equals(24));
      value.data = ['dummy'];
      expect(value.length, equals(5));
    });
  });
}
