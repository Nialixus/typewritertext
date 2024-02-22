part of '../typewritertext.dart';

class TypeWriterController extends ChangeNotifier {
  TypeWriterController({
    required String text,
    Duration duration = const Duration(milliseconds: 50),
  })  : _length = text.length,
        _duration = duration;
  final int _length;
  final Duration _duration;
  String _text = '';
  late bool _stop = value < _length;

  Future<void> start({int? value}) async {
    if (!_stop) {
      await Future.delayed(_duration);
      if (value != null) {
        this.value = value++;
      } else {
        this.value++;
      }
      notifyListeners();
      await start();
    }
  }

  Future<void> stop() async {
    _stop = true;
  }
}
