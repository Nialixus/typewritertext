part of '../typewritertext.dart';

/// New simple typewriter animation widget.
///
/// ```dart
/// return TypeWriter.text(
///   text: 'Hello World',
///   duration: const Duration(milliseconds: 50),
/// };
/// ```
class TypeWriter extends StatefulWidget {
  /// Constructor for [TypeWriter].
  ///
  /// [controller] is the controller for the animation.
  /// [builder] is the builder for the widget.
  /// [enabled] is the flag to enable the animation or not.
  ///
  /// ```dart
  /// return TypeWriter(
  ///   controller: controller,
  ///   builder: (context, value) => Text(value.text),
  /// );
  /// ```
  TypeWriter({
    super.key,
    this.enabled = true,
    required this.controller,
    required this.builder,
  })  : text = controller!.value.data,
        repeat = controller.repeat,
        onChanged = null,
        duration = controller.duration,
        textAlign = null,
        style = null,
        maxLines = null,
        overflow = null,
        semanticsLabel = null,
        softWrap = null,
        strutStyle = null,
        locale = null,
        textDirection = null,
        textHeightBehavior = null,
        textWidthBasis = null,
        selectionColor = null,
        maintainSize = false,
        alignment = null;

  /// Constructor for [TypeWriter.text].
  ///
  /// [text] is the text to be displayed during the typewriter animation.
  /// [enabled] is the flag to enable the animation or not.
  /// [onChanged] is the callback function for when the text is changed.
  /// [repeat] specifies whether the animation should repeat once completed (default is `false`).
  /// [textAlign] is the alignment of the text.
  /// [style] is the style of the text.
  /// [maxLines] is the maximum number of lines to be displayed.
  /// [overflow] is the overflow behavior of the text.
  /// [semanticsLabel] is the semantics label of the text.
  /// [softWrap] specifies whether the text should break at soft line breaks.
  /// [strutStyle] is the strut style of the text.
  /// [locale] is the locale of the text.
  /// [textDirection] is the text direction of the text.
  /// [textHeightBehavior] is the text height behavior of the text.
  /// [textWidthBasis] is the text width basis of the text.
  /// [selectionColor] is the color of the selection.
  /// [maintainSize] specifies whether the size of the text should be maintained.
  /// [alignment] is the alignment of the layout text.
  /// [duration] is the duration of the animation.
  ///
  /// ```dart
  /// return TypeWriter.text(
  ///   'Hello World',
  ///   duration: const Duration(milliseconds: 50),
  /// );
  /// ```
  TypeWriter.text(
    String text, {
    super.key,
    this.enabled = true,
    this.onChanged,
    this.repeat = false,
    this.textAlign,
    this.style,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    this.softWrap,
    this.strutStyle,
    this.locale,
    this.textDirection,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.selectionColor,
    this.maintainSize = true,
    this.alignment,
    required this.duration,
  })  : text = [text],
        controller = null,
        builder = null,
        assert(alignment != null && maintainSize || alignment == null,
            'If alignment is not null, maintainSize should be true.');

  /// Specifies whether the animation should repeat once completed (default is `false`).
  final bool repeat;

  /// Is the flag to play the animation or not.
  final bool enabled;

  /// Specifies whether the size of the layout text should be maintained.
  final bool maintainSize;

  /// Delay time between each character
  final Duration duration;

  /// Alignment of the text layout.
  final Alignment? alignment;

  /// The text to be displayed during the typewriter animation.
  final Iterable<String> text;

  /// Controller for the animation.
  final TypeWriterController? controller;

  /// Callback function for when the text is changed.
  final void Function(TypeWriterValue value)? onChanged;

  /// Builder for the widget.
  final Widget Function(BuildContext, TypeWriterValue value)? builder;

  /// Alignment of the text.
  final TextAlign? textAlign;

  /// Style of the text.
  final TextStyle? style;

  /// Maximum number of lines to be displayed.
  final int? maxLines;

  /// Overflow behavior of the text.
  final TextOverflow? overflow;

  /// Semantics label of the text.
  final String? semanticsLabel;

  /// Specifies whether the text should break at soft line breaks.
  final bool? softWrap;

  /// Strut style of the text.
  final StrutStyle? strutStyle;

  /// Locale of the text.
  final Locale? locale;

  /// Text direction of the text.
  final TextDirection? textDirection;

  /// Text height behavior of the text.
  final TextHeightBehavior? textHeightBehavior;

  /// Text width basis of the text.
  final TextWidthBasis? textWidthBasis;

  /// Color of the selection.
  final Color? selectionColor;

  @override
  State<TypeWriter> createState() => _X();
}

class _X extends State<TypeWriter> {
  //// Controller used in [TypeWriter].
  late final TypeWriterController controller;
  late bool _autoDispose;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          locale: widget.locale,
          maxLines: widget.maxLines,
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign ?? TextAlign.start,
          textDirection: widget.textDirection ?? TextDirection.ltr,
          textHeightBehavior: widget.textHeightBehavior,
          textWidthBasis: widget.textWidthBasis ?? TextWidthBasis.parent,
          text: TextSpan(
              text: controller.value.data.join(),
              style: widget.style,
              locale: widget.locale,
              semanticsLabel: widget.semanticsLabel),
        )..layout(
            maxWidth: constraints.maxWidth,
            minWidth: constraints.minWidth,
          );

        return ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            if (widget.onChanged != null) widget.onChanged!(controller.value);
            if (widget.builder != null) {
              return widget.builder!(context, controller.value);
            } else {
              return Container(
                alignment: widget.alignment,
                width: widget.maintainSize ? painter.width : null,
                height: widget.maintainSize ? painter.height : null,
                child: Text(
                  controller.value.text,
                  selectionColor: widget.selectionColor,
                  key: widget.key,
                  locale: widget.locale,
                  maxLines: widget.maxLines,
                  overflow: widget.overflow,
                  semanticsLabel: widget.semanticsLabel,
                  softWrap: widget.softWrap,
                  strutStyle: widget.strutStyle,
                  style: widget.style,
                  textAlign: widget.textAlign,
                  textDirection: widget.textDirection,
                  textHeightBehavior: widget.textHeightBehavior,
                  textWidthBasis: widget.textWidthBasis,
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      controller = widget.controller!;
      _autoDispose = false;
    } else {
      controller = TypeWriterController.fromValue(
        TypeWriterValue(widget.text),
        duration: widget.duration,
        repeat: widget.repeat,
      );
      _autoDispose = true;
    }

    if (widget.enabled) controller.start(controller.value.index);
  }

  @override
  void dispose() {
    if (_autoDispose) {
      controller.stop();
      controller.dispose();
    }
    super.dispose();
  }
}
