import 'dart:async';

class ChatGPTStreamExample extends Stream<String> {
  ChatGPTStreamExample({List<String>? message}) {
    chat(message: message);
  }

  final _controller = StreamController<String>();

  @override
  StreamSubscription<String> listen(
    void Function(String event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  Future<void> chat({List<String>? message}) async {
    int index = 0;
    List<String> response = message ??
        [
          "This",
          " is",
          " a",
          " stream",
          " controller",
          " test",
          " demonstrating",
          " how",
          " ChatGPT",
          " sends",
          " streams.",
          " Stream",
          " controllers",
          " play",
          " a",
          " pivotal",
          " role",
          " in",
          " managing",
          " data",
          " flow",
          " asynchronously",
          " 🎁.",
          "\n\nThey",
          " allow",
          " for",
          " controlled",
          " manipulation",
          " of",
          " data",
          " streams,",
          " enabling",
          " efficient",
          " handling",
          " of",
          " real-time",
          " updates",
          " and",
          " interactions.",
          " In",
          " the",
          " context",
          " of",
          " ChatGPT,",
          " stream",
          " controllers",
          " facilitate",
          " the",
          " transmission",
          " of",
          " continuous",
          " data",
          " streams,",
          " such",
          " as",
          " ongoing",
          " conversations",
          " or",
          " real-time",
          " responses",
          " to",
          " user",
          " inputs",
          " 🚀."
              "\n\nBy",
          " leveraging",
          " stream",
          " controllers,",
          " ChatGPT",
          " ensures",
          " seamless",
          " communication",
          " and",
          " responsiveness,",
          " essential",
          " for",
          " applications",
          " requiring",
          " dynamic",
          " and",
          " interactive",
          " content",
          " 🎉."
        ];

    if (response.isNotEmpty) _controller.add(response[index]);
    Timer.periodic(const Duration(milliseconds: 150), (_) {
      if (index + 1 < response.length) {
        index += 1;
        _controller.add(response[index]);
      }
    });
  }
}
