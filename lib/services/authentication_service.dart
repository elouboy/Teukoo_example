import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teukoo_code/UI/router.dart';
import 'package:teukoo_code/UI/views/login.dart';
import 'package:teukoo_code/UI/views/start.dart';
import 'package:teukoo_code/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo_code/managers/dialog_manager.dart';
import 'package:teukoo_code/models/user.dart';
import 'package:teukoo_code/service_locator.dart';
import 'package:teukoo_code/services/analytics_service.dart';
import 'package:teukoo_code/services/dialog_service.dart';
import 'package:teukoo_code/services/firestore_service.dart';
import 'package:teukoo_code/services/navigation_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NavigationService _navigationService = locator<NavigationService>();

  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  Users _currentUsers;
  Users get currentUser => _currentUsers;

  get authResult => authResult;

  BuildContext get context => context;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required int role,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      

      await authResult.user.sendEmailVerification();

      // create a new user profile on firestore
      _currentUsers = Users(
        id: authResult.user.uid,
        email: email,
        username: null,
        profileUrl: null,
        age: role,
        surname: null,
        bio: null,
      );
      
      await _firestoreService.createUser(_currentUsers);
      await _analyticsService.setUserProperties(
        userId: authResult.user.uid,
      );
      return authResult.user != null;
    }on FirebaseAuthException catch (e) {
     
      return e.message ;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user =   _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  Future<String> userToken() async {
    var user =   _firebaseAuth.currentUser;
    var idtoken = user.getIdToken().toString();
    return idtoken;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    _navigationService.navigateTo('/');
  
    
  }

  Future<void> resetPassword(String email) async {
    await authResult.sendPasswordResetEmail(email: email);
}
 
  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUsers = await _firestoreService.getUser(user.uid);
      await _analyticsService.setUserProperties(
        userId: user.uid,
      );
    }
  }

  bool isVerified() {
    if (authResult.isEmailVerified()) {
      return true;
    } else {
      return false;
    }
  }
}
