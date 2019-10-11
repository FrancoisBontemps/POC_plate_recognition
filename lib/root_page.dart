import 'package:flutter/material.dart';
import 'package:navigation_sample/navigation/destination.dart';
import 'package:navigation_sample/widgets/scan_button.dart';

class RootPage extends StatelessWidget {

  const RootPage({Key key, this.destination}) : super(key: key);
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return destination.index == 1
        ? Scaffold(
            appBar: AppBar(
              title: Center(child: Text(destination.title)),
              backgroundColor: destination.color,
            ),
            backgroundColor: destination.color[50],
            body: Center(
                child: Text("Settings menu incoming",
                    style: TextStyle(fontSize: 32))),
          )
        : Scaffold(
            appBar: AppBar(
              title:  Text(destination.title),
              backgroundColor: destination.color,
            ),
            backgroundColor: destination.color[50],
            body: Center(
                child: Text("On menu ${destination.index}",
                    style: TextStyle(fontSize: 32))),
            floatingActionButton: Center(heightFactor: 2, child: ScanButton()),
          );
  }
}
