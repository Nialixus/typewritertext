part of '../typewritertext.dart';

class TypeWriterController extends ValueNotifier<TypeWriterValue> {
  TypeWriterController({
    required String text,
    required this.duration,
    this.repeat = false,
  }) : super(TypeWriterValue([text]));

  TypeWriterController.fromValue(
    super.value, {
    required this.duration,
    this.repeat = false,
  });

  final Duration duration;
  final bool repeat;
  late bool _stop = value.index >= value.length - 1;

  Future<void> start([int? index]) async {
    if (!_stop) {
      await Future.delayed(duration);
      if (index != null) {
        value.index = index;
      } else {
        int index = value.index + 1;
        if (index > value.length && !repeat) {
          await stop();
        } else {
          value.index = index;
        }
      }
      notifyListeners();

      await start();
    }
  }

  Future<void> resume([int? index]) async {
    _stop = false;
    await start(index);
  }

  Future<void> stop() async {
    _stop = true;
  }
}
