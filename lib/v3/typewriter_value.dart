part of '../typewritertext.dart';

class TypeWriterValue {
  TypeWriterValue(
    this.data, {
    int index = 0,
  }) : _index = index;

  Iterable<String> data;
  int _index;

  int get length {
    return data.fold<int>(0, (p, n) => p + n.length) + data.length;
  }

  int get index {
    return _index % length;
  }

  set index(int index) => _index = index;

  String get text {
    var current = 0;
    var indexes = <List<int>>[];

    for (String item in data) {
      var index = <int>[];
      for (int i = 0; i < item.length + 1; i++) {
        index.add(current + i);
      }
      indexes.add(index);
      current = current + item.length + 1;
    }

    var index = indexes.indexWhere((e) => e.contains(this.index));
    return data.join().substring(
        (index < 0 ? indexes.last.first : indexes[index].first) % length,
        this.index);
  }

  @override
  String toString() {
    return 'TypeWriterValue{data: $data, text: $text, index: $index}';
  }
}
