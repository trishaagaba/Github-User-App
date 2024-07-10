import 'package:flutter/material.dart';
import "welcome_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Users App',
        // builder: (context, widget) {
        //   Widget error = const Text('...rendering error...');
        //
        //   if (widget is Scaffold || widget is Navigator) {
        //     error = Scaffold(body: Center(child: error));
        //   }
        //   ErrorWidget.builder = (errorDetails) => error;
        //   if (widget != null) return widget;
        //   throw StateError('widget is null');
        // },
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: WelcomePage()
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
