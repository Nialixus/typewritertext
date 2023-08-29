import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

void main() {
  runApp(MaterialApp(
      title: 'Typewritertext Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TypeWriterText(
                    repeat: false,
                    text: Text("Hello and Welcome.",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium),
                    duration: const Duration(milliseconds: 50)),
                TypeWriterText(
                    repeat: false,
                    text: Text("My name is Chris McBrien. ",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineLarge),
                    duration: const Duration(milliseconds: 100)),
                TypeWriterText(
                    repeat: false,
                    text: Text("Builder of things. ",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineLarge),
                    duration: const Duration(milliseconds: 50)),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TypeWriterText(
                      repeat: false,
                      text: Text(
                          "I'm a full-stack web and salesforce developer, schrum master, and solution architext.",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium),
                      duration: const Duration(milliseconds: 50)),
                ),
              ],
            ))));
  }
}
