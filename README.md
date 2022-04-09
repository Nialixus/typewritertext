# Type Writer Text
Type writer animation for Flutter.

## Preview
![screen-capture-_1_](https://user-images.githubusercontent.com/45191605/162557654-6e98d7be-e198-4089-bc13-6b52f7e4a6e2.gif)
## Install
<a href='https://pub.dev/packages/typewritertext/install'><img width='200px' src='https://pub.dev/static/img/pub-dev-logo.svg?hash=40fqenbgtbjcekk60vd5dg5mr22bv99t'/></a>
## Usage
`text` : required `Text()` widget.<br>
`duration` : required `Duration()`.<br>
`maintainSize` : to maintain occupied size of final text. default `true`.<br>
`play` : to switch animation state. default `true`.


```dart
const TypeWriterText(text: Text('text'), duration: Duration(milliseconds: 750));
```
