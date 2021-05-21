import 'package:flutter/material.dart';
import 'package:flutter_app/page_view/page_home.dart';
import 'package:flutter_app/page_view/page_one.dart';
import 'package:flutter_app/page_view/page_three.dart';
import 'package:flutter_app/page_view/page_two.dart';

void main() => runApp(PageViewHome());

class PageViewHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Title Flutter",
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageView"),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        reverse: false,
        controller: PageController(
          initialPage: 0,
          viewportFraction: 1,
          keepPage: true,
        ),
        physics:BouncingScrollPhysics(),
        pageSnapping: true,
        onPageChanged: (index) {
          //监听事件
          print('index=====$index');
        },
        children: <Widget>[
          PageHome(),
          PageOne(),
          PageTwo(),
          PageThree(),
        ],
      ),
    );
  }
}