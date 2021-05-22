import 'package:flutter/material.dart';
import 'package:test_project/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(      
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

