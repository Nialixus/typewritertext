# Type Writer Text

<a href='https://pub.dev/packages/typewritertext'><img src='https://img.shields.io/pub/v/typewritertext.svg?logo=flutter&color=blue&style=flat-square'/></a>\
\
A simple typewriter text animation wrapper for flutter. Supports iOS, Android, web, Windows, macOS, and Linux.

## Preview

![screen-capture-_1_](https://user-images.githubusercontent.com/45191605/162557654-6e98d7be-e198-4089-bc13-6b52f7e4a6e2.gif)

## Install

Add this line to your pubspec.yaml.

```yaml
dependencies:
  typewritertext: ^1.2.0
```

## Usage

First, import the typewriter package.

```dart
import 'package:typewritertext/typewritertext.dart';
```

And then put the widget like this.

```dart
const TypeWriterText(
    text: Text('text'),
    duration: Duration(milliseconds: 50),
);
```

## Documentation

- `text`, uses `Text()` widget.
- `duration`, uses to define how fast text changes.
- `alignment`, Align the `text` within the occupied size.
- `maintainSize`, to maintain occupied size of final text. Default value is `true`.
- `play`, to set whether animation should play or not. Default value is `true`.

Full documentation <a href="https://pub.dev/documentation/typewritertext/latest/typewritertext/typewritertext-library.html">here</a>.

## Example

- <a href="https://github.com/Nialixus/typewritertext/blob/master/example/lib/main.dart">typewritertext/example/lib/main.dart</a>
