<p align="center">
  <img src="https://user-images.githubusercontent.com/45191605/272785686-7a626063-6047-463a-b931-db256c708335.png" alt="TypeWeriter Text Dall-E Logo" width="150">
</p>

# Type Writer Text

<a href='https://pub.dev/packages/typewritertext'><img src='https://img.shields.io/pub/v/typewritertext.svg?logo=flutter&color=blue&style=flat-square'/></a>\
\
A simple typewriter text animation wrapper for flutter, supports iOS, Android, web, Windows, macOS, and Linux.

## Preview

![screen-capture-_1_](https://user-images.githubusercontent.com/45191605/162557654-6e98d7be-e198-4089-bc13-6b52f7e4a6e2.gif)

## Install

Add this line to your pubspec.yaml.

```yaml
dependencies:
  typewritertext: ^3.0.1
```

## Usage

First, import the typewriter package.

```dart
import 'package:typewritertext/typewritertext.dart';
```

### Version 1++
And to make basic `TypeWriterText` just make it like this
```dart
const TypeWriterText(
  text: Text('lorem ipsum dolor sit amet ...'),
  duration: Duration(milliseconds: 50),
);
```

Or if you want something that more customizable, use this

```dart
const TypeWriterText.builder(
  'Lorem ipsum dolor sit amet ...',
  duration: Duration(milliseconds: 50),
  builder: (context, value) {
    return AutoSizeText(
      value,
      maxLines: 2,
      minFontSize: 2.0,
    );
  }
);
```

### Version 3++
Now there is new version of `TypeWriterText`, 
where the text value that being used is not a `Text` widget but `Iterable<String>`.
Here's the basic example of it.

```dart
TypeWriter.text(
  'lorem ipsum dolot sit amet ...',
  duration: const Duration(milliseconds: 50),
);
```

And for the builder, you need to initiate a controller like this one.

```dart
final controller = TypeWriterController(text: 'Hello World',
  duration: const Duration(milliseconds: 50),
);

// also if you want the typewriter to not only changing
// the character but also words, you can use this controller.

final valueController = TypeWriterController.fromValue(
  ['First Paragraph', 'Next Paragraph', 'Last Paragraph'],
  duration: const Duration(milliseconds: 50),
);

TypeWriter(
  controller: controller,
  builder: (context, value) {
    return AutoSizeText(
      value.text,
      maxLines: 2,
      minFontSize: 2.0,
    ); 
  }
);
```

## Documentation
Full documentation <a href="https://pub.dev/documentation/typewritertext/latest/typewritertext/typewritertext-library.html">here</a>.

### Version 1++
| Property        | Purpose                                        |
|-----------------|------------------------------------------------|
| text            | Use widget [Text()](https://api.flutter.dev/flutter/widgets/Text-class.html). |
| duration        | Used to determine how fast text changes.        |
| alignment       | Align the `text` within the occupied size.      |
| maintainSize    | Used to maintain the occupied size of the final text. Default value is `true`. |
| play            | To set whether the animation should play or not. Default value is `true`. |
| repeat          | To set whether the animation should be repeated or not. Default value is `false`. |

### Version 3++
| Property             | Purpose                                                      |
|----------------------|--------------------------------------------------------------|
| repeat               | Specifies whether the animation should repeat once completed (default is `false`). |
| enabled              | Is the flag to play the animation or not.                    |
| maintainSize         | Specifies whether the size of the layout text should be maintained. |
| duration             | Delay time between each character.                          |
| alignment            | Alignment of the text layout.                                |
| text                 | The text to be displayed during the typewriter animation.   |
| controller           | Controller for the animation.                                |
| onChanged            | Callback function for when the text is changed.             |
| builder              | Builder for the widget.                                      |
| textAlign            | Alignment of the text.                                       |
| style                | Style of the text.                                          |
| maxLines             | Maximum number of lines to be displayed.                    |
| overflow             | Overflow behavior of the text.                              |
| semanticsLabel       | Semantics label of the text.                                |
| softWrap             | Specifies whether the text should break at soft line breaks.|
| strutStyle           | Strut style of the text.                                    |
| locale               | Locale of the text.                                         |
| textDirection        | Text direction of the text.                                 |
| textHeightBehavior   | Text height behavior of the text.                           |
| textWidthBasis       | Text width basis of the text.                               |
| selectionColor       | Color of the selection.                                     |

## Example

- <a href="https://github.com/Nialixus/typewritertext/blob/master/example/lib/main.dart">typewritertext/example/lib/main.dart</a>
