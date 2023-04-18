import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? colorAnimation;
  Animation? sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller!);
    sizeAnimation =
        Tween<double>(begin: 100.0, end: 200.0).animate(controller!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
      ),
      body: Center(
        child: Container(
          height: sizeAnimation!.value,
          width: sizeAnimation!.value,
          color: colorAnimation!.value,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller!.addListener(() {
            setState(() {
              colorAnimation =
                  ColorTween(begin: Colors.blue, end: Colors.yellow).animate(
                      CurvedAnimation(
                          parent: controller!, curve: Curves.bounceOut));
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
