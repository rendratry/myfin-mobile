import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadOverlay extends StatefulWidget {
  const LoadOverlay({Key? key}) : super(key: key);

  @override
  State<LoadOverlay> createState() => _LoadOverlayState();
}

class _LoadOverlayState extends State<LoadOverlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: Center(
        child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_4gebyeyd.json',
            width: 250,
            height: 247
        ),
      ),
    );
  }
}