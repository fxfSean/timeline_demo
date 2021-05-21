
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text(
          '第2页 ' + _fibonacci(30).toString(),
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
    );
  }

  static int _fibonacci(int i) {
    if(i <= 1) return i;
    return _fibonacci(i - 1) + _fibonacci(i - 2);
  }
}
