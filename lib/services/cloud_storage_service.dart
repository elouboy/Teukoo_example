import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String id,
  }) async {
    var imageFileName =
        id + DateTime.now().millisecondsSinceEpoch.toString();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("users/profiles/$imageFileName");

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
        imageUrl: url,
        imageFileName: imageFileName,
      );
    }

    return null;
  }

  Future deleteImage(String imageFileName) async {
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({this.imageUrl, this.imageFileName});
}