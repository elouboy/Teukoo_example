import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teukoo_code/UI/widgets/my_material.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/avatar.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/my_flutter_app_icons.dart';
import 'package:teukoo_code/models/user.dart';
import 'package:teukoo_code/service_locator.dart';
import 'package:teukoo_code/services/authentication_service.dart';
import 'package:teukoo_code/services/cloud_storage_service.dart';
import 'package:teukoo_code/services/dialog_service.dart';
import 'package:teukoo_code/services/navigation_service.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  get currentUserId => _authenticationService.currentUser.id;
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  Future updateProfile(
      {String id,
      File image,
       String surname,
       String bio}) async {
    CloudStorageResult storageResult;


    if(image != null){
    storageResult = await _cloudStorageService.uploadImage(
      imageToUpload: image,
      id: id,
    );
    
     _usersCollectionReference
        .doc(_authenticationService.currentUser.id)
        .update({
      "surname": surname,
      "bio": bio,
      "profileUrl": storageResult.imageUrl,
      "imagePath": storageResult.imageFileName,
    });
    
    }
    else{
     _usersCollectionReference
        .doc(_authenticationService.currentUser.id)
        .update({
      "surname": surname,
      "bio": bio,
    });

   
    }
  }

  Widget buildTextField({String name, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            name,
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
        ),
        TextField(
          style: TextStyle(color: Color(0xFFFFFFFF)),
          decoration: InputDecoration(
            hintText: name,
            hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF))),
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF))),
          ),
          controller: controller,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _usersCollectionReference
            .doc(_authenticationService.currentUser.id)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());

          Users user = Users.fromDocument(snapshot.data);

          surnameController.text = user.surname;
          bioController.text = user.bio;

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF313947),
                title: Text(
                  "Edit Profile",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                leading: IconButton(
                    icon: Icon(Icons.close, color: Color(0xFFFFFFFF)),
                    onPressed: _navigationService.pop),
                actions: [
                  IconButton(
                      icon: Icon(
                        MyFlutterApp.tick,
                        color: Color(0xFFFFFFFF),
                      ),
                      onPressed: () async {
                        if(user.imagePath != null){
                          await _cloudStorageService.deleteImage(user.imagePath);
                        }
                        updateProfile(
                            id: _authenticationService.currentUser.id,
                            image: _image,
                            surname: surnameController.text,
                            bio: bioController.text);
                        _navigationService.pop();
                      }),
                ],
              ),
              backgroundColor: MyColor.primaryBackground,
              body: SingleChildScrollView(
                child: InkWell(
                  onTap: (() =>
                      {FocusScope.of(context).requestFocus(FocusNode())}),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: AvatarProfile(
                            avatarImage: _image,
                            avatarUrl: user.profileUrl,
                          ),
                        ),
                        FlatButton(
                            onPressed: () async {
                              _image = await ImagePicker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {});
                            },
                            child: Text(
                              "Change Photo",
                              style: const TextStyle(
                                  color: MyColor.nextCamera,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            )),
                        Column(
                          children: <Widget>[
                            buildTextField(
                                name: "Surname", controller: surnameController),
                            buildTextField(
                                name: "Bio", controller: bioController),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
