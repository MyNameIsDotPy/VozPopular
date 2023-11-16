import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService extends ChangeNotifier{
  // Auth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();

    } on FirebaseAuthException catch (e) {

      if (e.code == "requires-recent-login") {
        await _reAuthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {

      // Handle general exception
    }
  }
  Future<void> _reAuthenticateAndDelete() async {
    try {
      final providerData = _firebaseAuth.currentUser?.providerData.first;

      if (GoogleAuthProvider().providerId == providerData!.providerId) {
        await _firebaseAuth.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await _firebaseAuth.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }

  String getUID(){
    return _firebaseAuth.currentUser!.uid;
  }

  // User sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try{
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    }
    on FirebaseAuthException catch (e){
      throw Exception(e.toString());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    }
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  Future<bool> signUpWithEmailAndPassword(
      String email, String password) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return true;
    } on FirebaseAuthException catch (e){
      throw Exception(e.toString());
    }
  }

  // Register user
  Future<bool> registerUser(email, password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      return false;
    }
  }

  // User sign out
  Future<void> signOut() async{

    if (_googleSignIn.currentUser != null) {
      // Disconnect from Google
      await _googleSignIn.disconnect();
    }
    return await _firebaseAuth.signOut();
  }
}