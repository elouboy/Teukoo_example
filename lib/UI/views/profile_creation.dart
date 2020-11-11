import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teukoo/UI/shared/ui_helpers.dart';
import 'package:teukoo/UI/widgets/my_material.dart';
import 'package:teukoo/UI/widgets/my_widgets/busy_button.dart';
import 'package:teukoo/services/authentication_service.dart';
import 'package:teukoo/viewmodels/create_profile.dart';
import 'package:teukoo/UI/widgets/my_widgets/input_field.dart';
import 'package:teukoo/models/user.dart';
import 'package:teukoo/service_locator.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:teukoo/UI/widgets/my_widgets/avatar.dart';

class ProfileSettings extends StatefulWidget {
  final Users user;
  final VoidCallback onUserProfileUpdated;
  const ProfileSettings(this.user, {Key key, this.onUserProfileUpdated})
      : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  File _image ;
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreateProfileViewModel>.withConsumer(
      // ignore: deprecated_member_use
      viewModel: CreateProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: MyColor.primaryBackground,
        body: SingleChildScrollView(
          child: InkWell(
            onTap: (() => {FocusScope.of(context).requestFocus(FocusNode())}),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                    ),
                    verticalSpaceMedium,
                    AvatarImage(
                      avatarImage: _image,
                      onTap: () async {
                        _image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {});
                      },
                    ),
                    verticalSpaceMedium,
                    InputField(
                      placeholder: 'Username',
                      controller: usernameController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'surname',
                      controller: surnameController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      controller: bioController,
                      placeholder: 'bio',
                      maxLines: 2,
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BusyButton(
                            title: 'Create Profile',
                            busy: model.busy,
                            onPressed: () {
                              model.createProfile(
                                  id: _authenticationService.currentUser.id,
                                  image: _image,
                                  username: usernameController.text,
                                  surname: surnameController.text,
                                  bio: bioController.text);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
