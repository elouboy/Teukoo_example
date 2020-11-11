import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/utils/image_selector.dart';
import 'package:video_player/video_player.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  final Function onTap;

  const Avatar({this.avatarUrl, this.onTap});
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: avatarUrl == null
            ? CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/logoImage.png'),
              )
            : CircleAvatar(
                radius: 50.0,
                backgroundImage: CachedNetworkImageProvider(avatarUrl),
              ),
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  final File avatarImage;
  final Function onTap;

  const AvatarImage({this.avatarImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: CircleAvatar(
              radius: 50.0,
              child: ClipOval(
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: (avatarImage == null)
                      ? Image.asset(
                          'assets/logoImage.png',
                          fit: BoxFit.fill,
                        )
                      : Image.file(avatarImage, fit: BoxFit.fill),
                ),
              )),
        ),
      ),
    );
  }
}

class AvatarProfile extends StatelessWidget {
  final File avatarImage;
  final String avatarUrl;

  const AvatarProfile({this.avatarImage, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircleAvatar(
          radius: 50.0,
          child: ClipOval(
            child: SizedBox(
              width: 180,
              height: 180,
              child: (avatarImage == null)
                  ?(avatarUrl != null) 
                  ?CircleAvatar(
                      radius: 50.0,
                      backgroundImage: CachedNetworkImageProvider(avatarUrl))
                  :CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/logoImage.png'),)
                  : Image.file(avatarImage, fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}


  class ChallengeCanva extends StatefulWidget {
    final File canvaVideo;
  final Function onTap;

  const ChallengeCanva({Key key, this.canvaVideo, this.onTap}) : super(key: key);

  
    @override
    _ChallengeCanvaState createState() => _ChallengeCanvaState(canvaVideo, onTap);
  }
  
  class _ChallengeCanvaState extends State<ChallengeCanva> {
  final File canvaVideo;
  final Function onTap;
  VideoPlayerController _controller;
  

  _ChallengeCanvaState(this.canvaVideo, this.onTap);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height:186,
      margin: EdgeInsets.only(top:10, left:15),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      border: Border.all(
        color: (canvaVideo == null) ? Color(0xFFFFFFFF) : null
      ),
      ),
      child: (canvaVideo == null) 
      ? GestureDetector(
        onTap: onTap,
        child: Text('Tap to pick a video', style: TextStyle(color: Color(0xFFFFFFFF)),),
      )
      : VideoPlayer(_controller),
    );
  }

}