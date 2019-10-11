import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

class Cameras extends ChangeNotifier {

  List<CameraDescription> _cameras;
  CameraController _controller;
  CameraController get getController => _controller;
  set setController(CameraController c) => _controller = c;


   initCameras () async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras.first, ResolutionPreset.medium);
    notifyListeners();
  }
}