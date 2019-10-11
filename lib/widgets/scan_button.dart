import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 75,
      child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/camera');
          },
          label: RichText(
              text: TextSpan(
                text: 'Scan your plate',
                style: TextStyle(fontSize: 28),
              )),
          icon: Icon(Icons.camera, size: 70),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
    );
  }
}
