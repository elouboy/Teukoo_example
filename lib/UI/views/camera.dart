import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teukoo/UI/shared/appColors.dart';
import 'package:teukoo/constants/route_names.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/navigation_service.dart';
import 'package:path/path.dart';


class Camera extends StatefulWidget {
  

  

  @override
  CameraState createState() {
    return new CameraState();
  }
}

class CameraState extends State<Camera> {
CameraController controller;
List cameras;
int selectedCameraIdx;
String imagePath;
String videoPath;
final NavigationService _navigationService = locator<NavigationService>();

 @override
void initState() {
  super.initState();
  // 1
  availableCameras().then((availableCameras) {
    
    cameras = availableCameras;
    if (cameras.length > 0) {
      setState(() {
        // 2
        selectedCameraIdx = 0;
      });

      _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
    }else{
      print("No camera available");
    }
  }).catchError((err) {
    // 3
    print('Error: $err.code\nError Message: $err.message');
  });
}

  Future _initCameraController(CameraDescription cameraDescription) async {
  if (controller != null) {
    await controller.dispose();
  }

  // 3
  controller = CameraController(cameraDescription, ResolutionPreset.high);

  // If the controller is updated then update the UI.
  // 4
  controller.addListener(() {
    // 5
    if (mounted) {
      setState(() {});
    }

    if (controller.value.hasError) {
      print('Camera error ${controller.value.errorDescription}');
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
  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Scaffold();
    }
    return new AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Scaffold(
        body:Stack(
        children: <Widget>[
          CameraPreview(controller),
          AppBar(
            backgroundColor: Colors.transparent,
            
            
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(right: 10),
              height: 80,
              width: double.infinity,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: <Widget>[
                  IconButton(
                  icon: Icon(Icons.add_box, color: Color(0xFFFFFFFF)),
                  onPressed: null),
                  Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(width: 2, color: Colors.white)),
                    child: GestureDetector(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.camButton),
                    ),
                    onLongPress: controller != null && 
                              controller.value.isInitialized && 
                              !controller.value.isRecordingVideo
                              ?_onRecordButtonPressed
                             : null,
                    onLongPressUp: _onStopButtonPressed,
                    onTap: () {
                  _onCapturePressed(context);
                }
                    ),
                  ),
                  _cameraTogglesRowWidget(),
                  
                ],
              ),
            ),
          )
        ],
      ),
      ),
    );
  }
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();


  

  
  Future<void> _onCameraVideoSwitched(CameraDescription cameraDescription) async {
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

    _onCameraVideoSwitched(selectedCamera);

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
      _showVideoCameraException(e);
      return null;
    }
  }

  void _showVideoCameraException(CameraException e) {
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

  void _onCapturePressed(context) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Attempt to take a picture and log where it's been saved
      final path = join(
        // In this example, store the picture in the temp directory. Find
        // the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        
        '${DateTime.now()}.png',
      );
      print(path);
      await controller.takePicture(path);
       

      // If the picture was taken, display it on a new screen
      _navigationService.navigateTo(PreviewScreenRoute,  arguments: path);
      
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

   void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    print('Error: ${e.code}\n${e.description}');
  }

  Widget _cameraTogglesRowWidget() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return  FlatButton(
            onPressed: _onSwitchCamera,
            child: Icon(_getCameraLensIcon(lensDirection),color: Color(0xFFFFFFFF),),
         
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.autorenew ;
      case CameraLensDirection.front:
        return Icons.autorenew ;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  /*void _onSwitchCamera() {
    selectedCameraIdx =
    selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera);
  }*/
}
