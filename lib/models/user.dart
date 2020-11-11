

import 'package:cloud_firestore/cloud_firestore.dart';

class Users{

final String id;
final String email;
final String username;
final String profileUrl;
final String imagePath;
final int age;
final String surname;
final String bio;

  Users( {this.id, this.email, this.username, this.profileUrl,this.imagePath, this.age, this.surname, this.bio} );

 factory Users.fromDocument(DocumentSnapshot document){
   Map getUsers = document.data();
   return Users(
   id : document.id,
   email : getUsers['email'],
   username : getUsers['username'],
   profileUrl : getUsers['profileUrl'],
   imagePath: getUsers['imagePath'],
   age : getUsers['age'],
   surname : getUsers['surname'],
   bio : getUsers['bio'],
   );
 
 }
   
   


   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'email': email,
       'username': username,
       'profileUrl': profileUrl,
       'imagePath': imagePath,
       'age': age,
       'surname':surname,
       'bio':bio,
     };
   }
}


 class UserSearch{
final String id;
final String username;
final String profileUrl;
final String surname;

UserSearch(this.id,this.profileUrl, this.username, this.surname, );

 }