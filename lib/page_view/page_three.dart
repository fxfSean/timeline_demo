
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page_view/page_four.dart';

class PageThree extends StatefulWidget {
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      child: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => PageFour()));
          },
          child: Text(
            '第3页',
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}



