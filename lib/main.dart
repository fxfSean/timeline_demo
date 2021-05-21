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
          appBar: AppBar(
            title: Text('This is Title'),
          ),
          body: _HomeWidget()
      ),
    );
  }
}

class _HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push<void>(MaterialPageRoute(
                    builder: (_) => PageViewHome()));
              },
              child: Text("pageView"))
        ],
      ),
    );
  }
}

