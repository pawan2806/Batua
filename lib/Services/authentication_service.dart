import 'package:batua/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.reference().child("Users");

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void addData(String data, String uid) {
    databaseRef.child(uid).set({'email': data});
  }
  Future<bool> addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notFirstUser', false);
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (user.emailVerified) {
        return true;
      } else {
        FirebaseAuth.instance.signOut();
        return false;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<dynamic> registerWithEmailAndPassword(

      String email, String password) async {
    try {

      final User user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password)).user;
      addBoolToSF();
      addData(user.email, user.uid);

      // Email Verification Sending
      user.sendEmailVerification();

      // Without that: If user sign up and close this app and then reopen the app,
      // Without verified log-in user navigate to the home page
      FirebaseAuth.instance.signOut();

      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
