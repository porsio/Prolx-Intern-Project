//import 'dart:html';
import 'package:Prolx/functionalities/auth.dart';
import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:flutter/material.dart';

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  AuthService auth = new AuthService();
  bool gs;
  /* Future<void> gsignIn(context) async {
    Navigator.of(context).pushNamed('/loading');
    gs = await auth.googleSignIn();
    Navigator.of(context).pop();
    if (gs == true) {
      Navigator.of(context).pushNamed('/navigation');
    } else {
      _showAlertDialog(context);
    }
  } */

  void _showAlertDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Error in Signing Up',
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Retry'))
            ],
          );
        });
  }

  Future<void> signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pushNamed('/loading');
      bool value =
          await _auth.signUpWithEmail(email: _email, password: _password);
      if (value == true) {
        FirestoreService().checkRegistered().then((value) {
          if (value) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/navigation', (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/registration', (Route<dynamic> route) => false);
          }
        });
      } else {
        Navigator.of(context).pop();
        _showAlertDialog(context);
      }
    }
  }

  String validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address.';
    else
      return null;
  }

  String validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            //height: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .2),
                      ),
                      Center(
                        child: Text(
                          "Sign Up with Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          validator: validateEmail,
                          onSaved: (input) {
                            _email = input;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 10)),
                            hintText: "xyz@email.com",
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: validatePassword,
                          onSaved: (input) {
                            _password = input;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 10)),
                            hintText: "Password",
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: RaisedButton(
                              color: Color.fromARGB(255, 255, 255, 255),
                              onPressed: signUp,
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
