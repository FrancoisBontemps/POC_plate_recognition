import 'package:flutter/material.dart';
import 'package:navigation_sample/navigation/destination.dart';
import 'package:navigation_sample/root_page.dart';
import 'package:navigation_sample/camera_page.dart';
import 'package:provider/provider.dart';
import 'package:navigation_sample/provider/cameras_provider.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Cameras>(
        builder: (_) => Cameras(),
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case '/':
                    return RootPage(destination: widget.destination);
                  case '/camera':
                    return Camera(destination: widget.destination);
                }
              },
            );
          },
        ));
  }
}
