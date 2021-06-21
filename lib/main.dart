import 'package:flutter/material.dart';
import 'package:flutter_app/page_view/main.dart';
import 'package:flutter_app/page_view/page_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Title Flutter",
      home: Scaffold(
          body: PageViewHome()
      ),
    );
  }
}