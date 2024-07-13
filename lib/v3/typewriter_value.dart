part of '../typewritertext.dart';

/// Value used in [TypeWriterController].
///
/// [data] is a list of [String] text to be written.
/// [index] is the end index of the text that want to be written.
///
/// ```dart
/// final value = TypeWriterValue(['Hello ', 'World'], index: 5);
/// print(value.text); // Hello
/// ```
class TypeWriterValue {
  /// Constructor for [TypeWriterValue].
  ///
  /// [data] is a list of [String] text to be written.
  /// [index] is the end index of the text that want to be written.
  /// ```dart
  /// final value = TypeWriterValue(['Hello ', 'World'], index: 5);
  /// print(value.text); // Hello
  /// ```
  TypeWriterValue(
    this.data, {
    int index = 0,
  }) : _index = index;

  /// List of [String] text to be written where each item
  /// will replace the previous one based on the given [index].
  Iterable<String> data;

  int _index;

  /// Total length of [data].
  int get length {
    final result = data.fold<int>(0, (p, n) => p + n.runes.toList().length);
    assert(result > 0, 'Length of text data must be greater than 0');
    return result;
  }

  /// End index of the text that want to be written.
  int get index {
    return _index % length;
  }

  /// Set new value of the end index.
  set index(int index) => _index = index;

  List<List<int>> get _indexes {
    var current = 0;
    var indexes = <List<int>>[];

    for (String item in data) {
      var index = <int>[];
      for (int i = 0; i < item.runes.length; i++) {
        index.add(current + i);
      }
      indexes.add(index);
      current = current + item.runes.length;
    }

    return indexes;
  }

  /// Current displayed text based on given [index].
  String get text {
    var index = _indexes.indexWhere((e) => e.contains(this.index));
    return runeSubstring(
        input: data.join(),
        start:
            (index < 0 ? _indexes.last.first : _indexes[index].first) % length,
        end: this.index + 1);
  }

  String runeSubstring(
      {required String input, required int start, required int end}) {
    return String.fromCharCodes(input.runes.toList().sublist(start, end));
  }

  @override
  String toString() {
    return 'TypeWriterValue{data: $data, text: $text, index: $index}';
  }
}
