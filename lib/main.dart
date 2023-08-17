import 'package:flutter/material.dart';
import 'package:todolist/homescreen.dart';
import 'package:todolist/addnotes.dart';

import 'Edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Todo (),
    );
  }
}

