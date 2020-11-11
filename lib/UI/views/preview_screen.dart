import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:teukoo/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo/UI/widgets/my_widgets/my_flutter_app_icons.dart';
import 'package:teukoo/constants/route_names.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/navigation_service.dart';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.primaryBackground,
        body: Column(children: <Widget>[
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
                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        child: Image.file(File(widget.imagePath),
                            fit: BoxFit.cover)),
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
            ),
          ),
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
              /*Padding(
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
                    onPressed: () {_navigationService.navigateTo(EditChallengeRoute,arguments: widget.imagePath);},
                  ),
                ),
              ),*/
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: MyColor.colorEditProfile,
                ),
                onPressed: () {
                  getBytesFromFile().then((bytes) {
                    Share.file('Share via:', basename(widget.imagePath),
                        bytes.buffer.asUint8List(), 'image/png');
                  });
                },
              )
            ],
          )
        ]),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}
