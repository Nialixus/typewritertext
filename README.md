# Type Writer Text
A simple typewriter text animation for flutter. Supports iOS, Android, web, Windows, macOS, and Linux.

## Preview
![screen-capture-_1_](https://user-images.githubusercontent.com/45191605/162557654-6e98d7be-e198-4089-bc13-6b52f7e4a6e2.gif)
## Install
Go to <a href='https://pub.dev/packages/typewritertext/install'><img width='80px' src='https://pub.dev/static/img/pub-dev-logo.svg?hash=40fqenbgtbjcekk60vd5dg5mr22bv99t'/></a>
## Usage
* `text`, uses `Text()` widget.<br>
* `duration`, uses to define how fast text changes.<br>
* `maintainSize`, to maintain occupied size of final text, default is `true`.<br>
* `play`, to set whether animation should play or not, default is `true`.

```dart
const TypeWriterText(text: Text('text'), duration: Duration(milliseconds: 750));
``` 
