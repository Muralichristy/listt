import 'package:flutter/material.dart';
import 'package:lists/list.dart';
import 'package:lists/nextpage.dart';
import 'package:lists/pageview.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lists(),
    );
  }

}

// onEdit: (String ) {  }, numbers: '',

