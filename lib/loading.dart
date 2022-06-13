
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future loadingprogess(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          children: <Widget>[
            Container(
                decoration: new BoxDecoration(color: Colors.transparent),
                alignment: Alignment.center,
                height: 240,
                child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_yiwbxvh3.json',
                 ),
            ),
          ],
        )
      )
      );

}