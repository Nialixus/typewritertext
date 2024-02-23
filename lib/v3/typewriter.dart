part of '../typewritertext.dart';

class TypeWriter extends StatefulWidget {
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

  final bool repeat;
  final bool enabled;
  final bool maintainSize;
  final Duration duration;
  final Alignment? alignment;
  final Iterable<String> text;
  final TypeWriterController? controller;
  final void Function(TypeWriterValue value)? onChanged;
  final Widget Function(BuildContext, TypeWriterValue value)? builder;
  final TextAlign? textAlign;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? semanticsLabel;
  final bool? softWrap;
  final StrutStyle? strutStyle;
  final Locale? locale;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;
  final Color? selectionColor;

  @override
  State<TypeWriter> createState() => _X();
}

class _X extends State<TypeWriter> {
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
    if (_autoDispose) controller.dispose();
    super.dispose();
  }
}
