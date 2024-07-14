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

  /// Add [text] to the existing [data] and returns
  /// a new [TypeWriterValue] instance with the updated data and index.
  ///
  /// ```dart
  /// final value = TypeWriterValue(['Hello ', 'World']);
  /// final value2 = value + ' 👑'
  /// print(value2.text); // Hello World 👑
  /// ```
  TypeWriterValue operator +(String text) {
    String value = [...data, text].join();
    return TypeWriterValue(
      [value],
      index: value.runes.length - 1,
    );
  }

  /// List of [String] text to be written where each item
  /// will replace the previous one based on the given [index].
  Iterable<String> data;

  int _index;

  /// Total length of [data].
  int get length {
    return data.fold<int>(0, (previous, current) {
      return previous + current.runes.length;
    });
  }

  /// End index of the text that want to be written.
  int get index {
    try {
      return _index % length;
    } catch (e) {
      return -1;
    }
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
      current += item.runes.length;
    }

    return indexes;
  }

  /// Current displayed text based on given [index].
  String get text {
    if (_indexes.isEmpty) return '';
    final index = _indexes.indexWhere((e) => e.contains(this.index));
    final start = index < 0 ? _indexes.last.first : _indexes[index].first;
    final end = this.index + 1;
    return String.fromCharCodes(
      data.join().runes.toList().sublist(start % length, end),
    );
  }

  @override
  String toString() {
    return 'TypeWriterValue(data: $data, text: $text, index: $index)';
  }
}
