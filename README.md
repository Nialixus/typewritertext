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
  typewritertext: ^3.0.0
```

## Usage

First, import the typewriter package.

```dart
import 'package:typewritertext/typewritertext.dart';
```

And then put the widget like this.

> Version 1
```dart
const TypeWriterText(
  text: Text('lorem ipsum dolor sit amet ...'),
  duration: Duration(milliseconds: 50),
);

// or you can use builder to integrate 
// with other widget like this

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

Or you can use new version by using this

> Version 3
```dart
TypeWriter.text(
  'lorem ipsum dolot sit amet ...',
  duration: const Duration(milliseconds: 50),
);

// now if you want to use builder
// you need to initiate controller

final controller = TypeWriterController(text: 'Hello World',
  duration: const Duration(milliseconds: 50),
);

// also if you want the typewriter to not only changing
// the character but also words, you can use this controller.

final advanceController = TypeWriterController.fromValue(
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

<table>
  <tr><td><b>Property</b></td><td><b>Purpose</b></td></tr>
  <tr><td><b><i>text<i></b></td><td>Use widget <a href='https://api.flutter.dev/flutter/widgets/Text-class.html'>Text()</a>.</td></tr>
  <tr><td><b><i>duration<i></b></td><td>Used to determine how fast text changes.</td></tr>
  <tr><td><b><i>alignment<i></b></td><td>Align the <b><i>text</i></b> within the occupied size.</td></tr>
  <tr><td><b><i>maintainSize<i></b></td><td>Used to maintain occupied size of final text. Default value is <b><i>true</i></b>.</td></tr>
  <tr><td><b><i>play<i></b></td><td>To set whether animation should play or not. Default value is <b><i>true</i></b>.</td></tr>
  <tr><td><b><i>repeat<i></b></td><td>To set whether animation should be repeated or not. Default value is <b><i>false</i></b>.</td></tr>
</table>

Full documentation <a href="https://pub.dev/documentation/typewritertext/latest/typewritertext/typewritertext-library.html">here</a>.

## Example

- <a href="https://github.com/Nialixus/typewritertext/blob/master/example/lib/main.dart">typewritertext/example/lib/main.dart</a>
