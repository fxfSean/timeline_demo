
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page_view/data_sets.dart';

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: Center(
        child: ListView(
          children: [
            for(var i=0;i<100000;i++) _buildItemWidget(i),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(int i) {
    var line = lines[i % lines.length];
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 18),
      child: Row(
        children: [
          Container(
            color: Colors.black,
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  line.substring(0,1),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child: Text(
            line,
            softWrap: false,
          ))
        ],
      ),
    );
  }
}
