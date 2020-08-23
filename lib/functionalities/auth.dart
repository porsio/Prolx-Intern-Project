import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firestoreServices.dart';
import 'localData.dart';

class AuthService {
  LocalData localData = new LocalData();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail({email: '', password: ''}) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        localData.saveData(
          userEmail: email,
          password: password,
          loggedIn: "yes",
          uid: user.uid,
        );

        return true;
      }
      return false;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUpWithEmail({email: '', password: ''}) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        await FirestoreService().createUser(user);
        await localData.saveData(
          userEmail: email,
          password: password,
          loggedIn: "yes",
          uid: user.uid,
        );
        return true;
      }
      return false;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loggedIn", "no");
    prefs.setString("userEmail", null);
    prefs.setString("password", null);
    prefs.setString('uid', null);
    prefs.setString("token", null);

    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  /* void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    ref.setData({
//      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  } */

}
