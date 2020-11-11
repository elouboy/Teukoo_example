import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:teukoo_code/UI/widgets/my_material.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo_code/constants/route_names.dart';
import 'package:teukoo_code/service_locator.dart';
import 'package:teukoo_code/services/navigation_service.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  final String videoFile;

  const VideoPreview({Key key, this.videoFile}) : super(key: key);
  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController _controller;
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.primaryBackground,
        body: Column(
          children: [
            Expanded(
                child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: Container(
                        height: 500,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: VideoPlayer(_controller),
                        )),
                  ),
                ),
                Positioned(
                    left: -1,
                    top: -1,
                    child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Color(0xFFFFFFFF),
                        ),
                        onPressed: _navigationService.pop))
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.photo_camera,
                      color: MyColor.colorEditProfile,
                    ),
                    onPressed: () {
                      _navigationService.navigateTo(CameraRoute);
                    }),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [MyColor.nextCamera, MyColor.closeCamera]),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        MyFlutterApp.tick,
                        color: Color(0xFFFFFFFF),
                      ),
                      onPressed:() {_navigationService.navigateTo(EditChallengeRoute,arguments: widget.videoFile );
                      _controller.pause();
                      },
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.share,
                      color: MyColor.colorEditProfile, 
                    ),
                    onPressed:
                        null /*() {
                    getBytesFromFile().then((bytes) {
                      Share.file('Share via:', basename(widget.videoFile),
                          bytes.buffer.asUint8List(), 'image/png');
                    });
                  },*/
                    )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.videoFile).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}
