import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:navigation_sample/navigation/destination.dart';
import 'package:provider/provider.dart';
import 'package:navigation_sample/provider/cameras_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Camera extends StatefulWidget {
  @override
  const Camera({
    Key key,
    this.destination,
  }) : super(key: key);
  final Destination destination;
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> _cameras;
  CameraController controller;
  final GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) {
      _cameras = availableCameras;
      if (_cameras.isNotEmpty) {
        _onCameraLoading(_cameras[0]).then((void v) {
          print('ok');
        });
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  Future _onCameraLoading(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        Fluttertoast.showToast(
            msg: 'Camera error ${controller.value.errorDescription}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.destination.title),
          backgroundColor: widget.destination.color,
        ),
        key: _scaffoldKey,
        body: Stack(children: <Widget>[
          Container(child: _cameraPreviewWidget()),
        ]));
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return Container(
      child: CameraPreview(controller),
    );
  }
}
