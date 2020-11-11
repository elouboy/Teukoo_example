import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lantern/flutter_lantern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teukoo/UI/shared/bottom_nav_bar.dart';
import 'package:teukoo/UI/views/video_preview.dart';
import 'package:teukoo/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo/constants/route_names.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/navigation_service.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';




class VideoRecorderExample extends StatefulWidget {
  @override
  _VideoRecorderExampleState createState() {
    return _VideoRecorderExampleState();
  }
}

class _VideoRecorderExampleState extends State<VideoRecorderExample> {
  CameraController controller;
  String videoPath;
  List<CameraDescription> cameras;
  int selectedCameraIdx;
  final NavigationService _navigationService = locator<NavigationService>();



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  

  @override
  void initState() {
    super.initState();

    // Get the listonNewCameraSelected of available cameras.
    // Then set the first camera as selected.
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryBackground,
      key: _scaffoldKey,
      bottomNavigationBar: AppBottomNav(),

      body: SafeArea(
        child:Container(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                  child:
                    _cameraPreviewWidget(),
                   
                 ),
              
              decoration: BoxDecoration(
                
                border: Border.all(
                  color: controller != null && controller.value.isRecordingVideo
                      ? MyColor.nextCamera
                      : MyColor.bottomBarcolor,
                  width: 3.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                
                _captureControlRowWidget(),
                _cameraTogglesRowWidget(),
                
                
              
              ],
            ),
          ),
          SizedBox(height: 10.0)
        ],
      ),
      ),
      ),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.autorenew;
      case CameraLensDirection.front:
        return Icons.autorenew;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  // Display 'Loading' text when the camera is still loading.
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

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    if (cameras == null) {
      return Row();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton(
            onPressed: _onSwitchCamera,
            child: Icon(_getCameraLensIcon(lensDirection), color: Color(0xFFFFFFFF),),
            ),
      ),
    );
  }

  /// Display the control bar with buttons to record videos.
  Widget _captureControlRowWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(colors: [MyColor.nextCamera, MyColor.closeCamera]),
                shape: BoxShape.circle,
              ),
                  child: IconButton(
                  icon: Icon( controller.value.isRecordingVideo
                        ? Icons.pause
                        : Icons.play_arrow,),
                  color: Color(0xFFFFFFFF),
                  onPressed: controller != null &&
                      controller.value.isInitialized &&
                      !controller.value.isRecordingVideo
                  ? _onRecordButtonPressed
                  : _onStopButtonPressed,
                ),
                ),
           
          ],
        ),
      ),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _onCameraSwitched(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        Fluttertoast.showToast(
            msg: 'Camera error ${controller.value.errorDescription}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
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

  void _onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];

    _onCameraSwitched(selectedCamera);

    setState(() {
      selectedCameraIdx = selectedCameraIdx;
    });
  }

  void _onRecordButtonPressed() {
    _startVideoRecording().then((String filePath) {
      if (filePath != null) {
        Fluttertoast.showToast(
            msg: 'Recording video started',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white);
      }
    });
  }

  void _onStopButtonPressed() {
    _stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      Fluttertoast.showToast(
          msg: 'Video recorded to $videoPath',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
    });
  }
  





 

  

  Future<String> _startVideoRecording() async {
    if (!controller.value.isInitialized) {
      Fluttertoast.showToast(
          msg: 'Please wait',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);

      return null;
    }

    // Do nothing if a recording is on progress
    if (controller.value.isRecordingVideo) {
      return null;
    }

    

      final Directory appDirectory = await getExternalStorageDirectory();
      final String videoDirectory = '${appDirectory.path}/Videos';
      print("${appDirectory.path}/Videos");
      await Directory(videoDirectory).create(recursive: true);
      final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
      final String filePath = '$videoDirectory/${currentTime}.mp4';

    try {
      await controller.startVideoRecording(filePath);
      videoPath = filePath;
      
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  Future<void> _stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
     _navigationService.navigateTo(VideoPreviewRoute, arguments: videoPath);
      
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}
