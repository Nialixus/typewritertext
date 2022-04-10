# Type Writer Text
A simple typewriter text animation for flutter. Supports iOS, Android, web, Windows, macOS, and Linux.

## Preview
![screen-capture-_1_](https://user-images.githubusercontent.com/45191605/162557654-6e98d7be-e198-4089-bc13-6b52f7e4a6e2.gif)
## Install
How to install is <a href='https://pub.dev/packages/typewritertext/install'>here</a>.
## Documentation
The documentation is <a href='https://pub.dev/documentation/typewritertext/latest/typewritertext/typewritertext-library.html'>here</a>.
## Usage
```dart
const TypeWriterText(
    text: Text('text'), 
    duration: Duration(milliseconds: 50),
);
``` 
* `text`, uses `Text()` widget.<br>
* `duration`, uses to define how fast text changes.<br>
* `alignment`, Align the `text` within the occupied size.<br>
* `maintainSize`, to maintain occupied size of final text. Default value is `true`.<br>
* `play`, to set whether animation should play or not. Default value is `true`.
