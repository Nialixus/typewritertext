import 'package:auto_size_text/auto_size_text.dart';
import 'package:example/stream.dart';
import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Typewritertext Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyNewApp(),
    ),
  );
}

class MyNewApp extends StatelessWidget {
  const MyNewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TypeWriter.text(
                "What is Lorem Ipsum? 🤔",
                maintainSize: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                duration: const Duration(milliseconds: 50),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TypeWriter(
                  controller: TypeWriterController(
                    text: "Lorem Ipsum is simply dummy text of "
                        "the printing and typesetting industry. "
                        "Lorem Ipsum has been the industry's standard "
                        "dummy text ever since the 1500s, when an unknown "
                        "printer took a galley of type and scrambled it to "
                        "make a type specimen book. It has survived not only "
                        "five centuries, but also the leap into electronic typesetting, "
                        "remaining essentially unchanged 🎉.",
                    duration: const Duration(milliseconds: 50),
                  ),
                  builder: (context, value) {
                    return AutoSizeText(
                      value.text,
                      maxLines: 4,
                      minFontSize: 2.0,
                      textAlign: TextAlign.left,
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TypeWriter(
                  controller: TypeWriterController.fromValue(
                    TypeWriterValue([
                      '🚀 First Paragraph',
                      'Second 🎁 Paragraph',
                      'Third Paragraph 🎉'
                    ]),
                    duration: const Duration(milliseconds: 200),
                    repeat: true,
                  ),
                  builder: (context, value) {
                    return Text(
                      '⎯ ${value.text}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 10.0,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TypeWriter(
                  controller: TypeWriterController.fromStream(
                    ChatGPTStreamExample(),
                  ),
                  builder: (context, value) => Text(value.text),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class MyOldApp extends StatelessWidget {
//   const MyOldApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SelectionArea(
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TypeWriterText(
//                   duration: const Duration(milliseconds: 50),
//                   text: Text("What is Lorem Ipsum?",
//                       textAlign: TextAlign.left,
//                       style: Theme.of(context).textTheme.titleMedium),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                   child: TypeWriterText.builder(
//                     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
//                     duration: const Duration(milliseconds: 50),
//                     builder: (context, value) {
//                       return AutoSizeText(
//                         value,
//                         maxLines: 2,
//                         minFontSize: 2.0,
//                         textAlign: TextAlign.left,
//                         style: const TextStyle(fontSize: 20.0),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
