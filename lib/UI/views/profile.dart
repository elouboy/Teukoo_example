import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teukoo/UI/shared/bottom_nav_bar.dart';
import 'package:teukoo/UI/widgets/my_widgets/avatar.dart';
import 'package:teukoo/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo/constants/route_names.dart';
import 'package:teukoo/models/user.dart';
import 'package:teukoo/service_locator.dart';
import 'package:teukoo/services/authentication_service.dart';
import 'package:teukoo/services/navigation_service.dart';

class Profile extends StatefulWidget {
  final String id;
  Profile({this.id});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with AutomaticKeepAliveClientMixin<Profile> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  get currentUserId => _authenticationService.currentUser.id;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
        stream: _usersCollectionReference.doc(widget.id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());
          Users user = Users.fromDocument(snapshot.data);

          return SafeArea(
            child: Scaffold(
              backgroundColor: MyColor.primaryBackground,
              appBar: AppBar(
                leading: widget.id != currentUserId
                    ? IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Color(0xFFFFFFFF),
                        ),
                        onPressed: _navigationService.pop)
                    : Icon(null),
                actions: [
                  widget.id == currentUserId
                      ? PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: FlatButton(
                                  child: Text('Settings'),
                                  onPressed: () {
                                    _navigationService
                                        .navigateTo(SettingsRoute);
                                  }),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: FlatButton(
                                  child: Text('Edit Profile'),
                                  onPressed: () {
                                    _navigationService
                                        .navigateTo(EditProfileRoute);
                                  }),
                            ),
                          ],
                          icon: Icon(
                            Icons.more_vert,
                            color: Color(0xFFFFFFFF),
                          ),
                        )
                      : Icon(null),
                ],
                backgroundColor: Color(0xFF313947),
                bottom: PreferredSize(
                  preferredSize: Size.fromRadius(110.0),
                  child: Container(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Avatar(
                        avatarUrl: user.profileUrl,
                      ),
                      Text(user.surname),
                      Text(user.bio),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: AppBottomNav(),
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

