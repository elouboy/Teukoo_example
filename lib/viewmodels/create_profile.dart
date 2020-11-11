import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teukoo_code/constants/route_names.dart';
import 'package:teukoo_code/service_locator.dart';
import 'package:teukoo_code/services/authentication_service.dart';
import 'package:teukoo_code/services/cloud_storage_service.dart';
import 'package:teukoo_code/services/dialog_service.dart';
import 'package:teukoo_code/services/firestore_service.dart';
import 'package:teukoo_code/services/navigation_service.dart';
import 'package:teukoo_code/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreateProfileViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final CollectionReference _usernameCollectionReference =
      FirebaseFirestore.instance.collection('users_username');

  get id => _authenticationService.currentUser.id;

  Future createProfile(
      {@required String id,
      File image,
      @required String username,
      @required String surname,
      @required String bio}) async {
    setBusy(true);
    CloudStorageResult storageResult;

    var user = _usernameCollectionReference.doc(username);

    var result;
    setBusy(false);
    user.get().then((document) async => {
          if (document.exists)
            {
              await _dialogService.showDialog(
                title: 'could not create username',
                description:
                    ' This username is not availaible, Please take another one',
              )
            }
          else
            {
              if (image != null)
                {
                  storageResult = await _cloudStorageService.uploadImage(
                    imageToUpload: image,
                    id: id,
                  ),
                  _firestoreService.createUsername(username),
                  result = await _firestoreService.updateUserWithPhoto(
                      id,
                      storageResult.imageUrl,
                      storageResult.imageFileName,
                      username,
                      surname,
                      bio),
                  if (result is String)
                    {
                      await _dialogService.showDialog(
                        title: 'Cound not create  your profile ',
                        description: result,
                      )
                    }
                  else
                    {
                      await _dialogService.showDialog(
                        title: 'profile  successfully Added',
                        description: 'Your profile  has been created',
                      ),
                    },
                  _navigationService.navigateTo(HomeViewRoute),
                }
              else
                {
                  _firestoreService.createUsername(username),
                  result = await _firestoreService.updateUserWithoutPhoto(
                      id, username, surname, bio),
                  if (result is String)
                    {
                      await _dialogService.showDialog(
                        title: 'Problem',
                        description: result,
                      )
                    }
                  else
                    {
                      await _dialogService.showDialog(
                        title: 'profile successfully Added',
                        description: 'your profile has been created',
                      )
                    },
                  _navigationService.navigateTo(HomeViewRoute),
                }
            },
        });
  }
}
