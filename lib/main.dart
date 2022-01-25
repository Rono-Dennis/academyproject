import 'package:academyproject/pages/baseLayout.dart';
import 'package:academyproject/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // title: 'Entertainment App',
      // theme: ThemeData(
      //
      //   primarySwatch: Colors.blue,
      // ),
      home: Home(),
    );
  }
}
