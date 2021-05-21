import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageFive extends StatefulWidget {
  const PageFive({Key key}) : super(key: key);

  @override
  _PageFiveState createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageFive"),
      ),
      body: _RotateAnim(),
    );
  }
}

class TranslateAnim extends StatefulWidget {
  const TranslateAnim({Key key}) : super(key: key);

  @override
  _TranslateAnimState createState() => _TranslateAnimState();
}

class _TranslateAnimState extends State<TranslateAnim>
    with SingleTickerProviderStateMixin {
  Animation<EdgeInsets> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 400), vsync: this);
    animation = new Tween<EdgeInsets>(
            begin: EdgeInsets.only(top: 10.0), end: EdgeInsets.only(top: 300.0))
        .animate(controller)
          ..addListener(() {
            setState(() {});
          });
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: animation.value,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 200,
        width: 200,
        child: FlutterLogo(),
      ),
    );
  }
}

class _RotateAnim extends StatefulWidget {
  const _RotateAnim({Key key}) : super(key: key);

  @override
  __RotateAnimState createState() => __RotateAnimState();
}

class __RotateAnimState extends State<_RotateAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotationTransition(
          turns: _animationController,
          alignment: Alignment.center,
          child: Container(width: 200, height: 200, child: FlutterLogo()),
        ),
        TextButton(
          onPressed: () {
            if (_animationController.isAnimating) {
              _animationController.stop();
            } else {
              _animationController.repeat();
            }
          },
          child: Container(
              width: 100,
              height: 100,
              child: Text(
                "Button",
              )),
        )
      ],
    );
  }
}
