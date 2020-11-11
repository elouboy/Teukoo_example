import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teukoo/UI/shared/bottom_nav_bar.dart';
import 'package:teukoo/UI/widgets/my_material.dart';
import 'package:teukoo/constants/route_names.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/navigation_service.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final NavigationService _navigationService = locator<NavigationService>();

  File _image;
  File _video;
  final picker = ImagePicker();

  Future open_gallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
    _navigationService.navigateTo(PreviewScreenRoute,
        arguments: pickedFile.path);
  }

  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);

    setState(() {
      _video = File(video.path);
    });

    _navigationService.navigateTo(VideoPreviewRoute, arguments: video.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryBackground,
      bottomNavigationBar: AppBottomNav(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Container(
              decoration: BoxDecoration(color: MyColor.nextCamera),
              child: RaisedButton(
                onPressed: () {
                  open_gallery();
                },
                child: Text(
                  "Get Image",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: MyColor.closeCamera,
            ),
            child: RaisedButton(
              onPressed: () {
                _pickVideo();
              },
              child: Text(
                "Get Video",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
