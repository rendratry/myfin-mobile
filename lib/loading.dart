
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future loadingprogess(context) async {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          title: Stack(
          children: <Widget>[
            Container(
                height : 240,
                decoration: new BoxDecoration(color: Colors.white),
                alignment: Alignment.center,
                child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_yiwbxvh3.json',
                 ),
            ),
          ],
        )
      )
      );

}