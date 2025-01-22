import 'dart:async';
import 'package:flutter/material.dart';
import 'package:career_canvas/src/ImagePath/ImageAssets.dart';

class SpinningLoader extends StatefulWidget {
  @override
  _SpinningLoaderState createState() => _SpinningLoaderState();
}

class _SpinningLoaderState extends State<SpinningLoader> {
  double _rotationAngle = 0;
  late Timer _timer;

  // This will continuously rotate the image
  void _startRotation() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _rotationAngle += 0.1; // Increment the rotation angle
        if (_rotationAngle >= 6.28) {
          _rotationAngle = 0; // Reset after one full rotation
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startRotation();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: _rotationAngle,
        child: Image.asset(
          ImageAssets.logo,
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
