import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var log = prefs.getString('loggedIn');
    print(log);
    if (log == 'yes')
      return true;
    else
      return false;
  }

  Future<void> saveData({
    userEmail: '',
    password: '',
    loggedIn: '',
    uid: '',
    token: '',
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userEmail", userEmail);
    prefs.setString("loggedIn", loggedIn);
    prefs.setString("password", password);
    prefs.setString("uid", uid);
    prefs.setString("token", token);
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString("userEmail");
    return userEmail;
  }

  Future<String> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid");
    return uid;
  }
}
