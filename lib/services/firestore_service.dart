import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teukoo/models/user.dart';



class FirestoreService {
  final CollectionReference _usersCollectionReference =
     FirebaseFirestore.instance.collection('users');
  final CollectionReference _usernameCollectionReference = FirebaseFirestore.instance.collection('users_username');

  

  Future createUser(Users user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    }on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future createUsername(String username) async {
    try{
     await  _usernameCollectionReference.doc(username).set({
       "username": username,
     });
    }on FirebaseException catch(e){
      return e.message;
    }
  }
  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return Users.fromDocument(userData);
    }on FirebaseException catch (e) {
      return e.message;
    }
  }

 
      


  Future updateUserWithPhoto(String id , String profileUrl,String imagePath,  String username, String surname, String bio ) async{
    try {
      await _usersCollectionReference.doc(id).update({
        "profileUrl" : profileUrl,
        "imagePath": imagePath,
        "surname": surname,
        "username": username,
        "bio": bio,
      });
    }on FirebaseException catch (e) {
      return e.message;
    }

  }

  Future updateUserWithoutPhoto(String id, String username, String surname, String bio) async{
      try {
        await _usersCollectionReference
                      .doc(id)
                      .update({
                    "username": username,
                    "surname": surname,
                    "bio": bio,
                  });
      }on FirebaseException catch (e) {
        return e.message;
      }
    }


  }

  
