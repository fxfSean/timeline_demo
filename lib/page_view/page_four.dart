import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page_view/page_five.dart';

class PageFour extends StatelessWidget {
  const PageFour({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Row(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                print("跳转第五页");
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PageFive()));
              },
              child: Text(
                '第4页',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
