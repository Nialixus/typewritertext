part of 'typewriter.dart';

/// Controller for [TypeWriter] widget.
///
/// This controller can be used to start and stop the animation.
/// ```dart
/// final controller = TypeWriterController(
///   text: 'Hello World',
///   duration: const Duration(milliseconds: 50)
/// );
///
/// return TypeWriter(
///   controller: controller,
///   builder: (context, value) => Text(value.text),
/// );
/// ```
class TypeWriterController extends ValueNotifier<TypeWriterValue> {
  /// Constructor for [TypeWriterController].
  ///
  /// [text] is the text to be written.
  /// [duration] is the delay time between each character.
  /// [repeat] specifies whether the animation should repeat once completed.
  ///
  /// ```dart
  /// final controller = TypeWriterController(
  ///   text: 'Hello World',
  ///   duration: const Duration(milliseconds: 50),
  /// );
  /// ```
  TypeWriterController({
    required String text,
    required this.duration,
    this.repeat = false,
  }) : super(TypeWriterValue([text]));

  /// Constructor for [TypeWriterController].
  ///
  /// [duration] is the delay time between each character.
  /// [repeat] specifies whether the animation should repeat once completed.
  /// [value] is the basic value for the animation.
  ///
  /// ```dart
  /// final controller = TypeWriterController(
  ///   value: TypeWriterValue(['Hello ', 'World']),
  ///   duration: const Duration(milliseconds: 50),
  /// );
  /// ```
  TypeWriterController.fromValue(
    super.value, {
    required this.duration,
    this.repeat = false,
  });

  /// Delay time between each character.
  final Duration duration;

  /// Specifies whether the animation should repeat once completed.
  final bool repeat;

  bool _stop = false;

  /// Starts the animation. [index] is the index to start from.
  Future<void> start([int? index]) async {
    try {
      if (!_stop) {
        await Future.delayed(duration);
        if (index != null) {
          value.index = index;
        } else {
          int index = value.index + 1;
          if (index >= value.length && !repeat) {
            stop();
          } else {
            value.index = index;
          }
        }
        notifyListeners();

        await start();
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  /// Resumes the animation. [index] is the index to start from.
  Future<void> resume([int? index]) async {
    _stop = false;
    await start(index);
  }

  /// Stops the animation.
  void stop() {
    _stop = true;
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
