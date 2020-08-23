import 'dart:io';

import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Prolx/functionalities/localData.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

Future<bool> wait() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return true;
  //return Future.delayed(Duration(seconds: 3)).then((value) => true);
}

class _MainScreenState extends State<MainScreen> {
  LocalData localData = new LocalData();
  String userEmail = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.red[100]),
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.1),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.red[200],
                                      Colors.red[400],
                                      Colors.red[800],
                                    ]),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.red[900],
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 15.0,
                                      spreadRadius: 1.0),
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-5.0, -5.0),
                                      blurRadius: 15.0,
                                      spreadRadius: 1.0),
                                ]),
                            height: 250,
                            width: double.maxFinite,
                          ),
                          Positioned(
                              child: Text(
                            'PROLX',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.5,
                                letterSpacing: 3,
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ))
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: localData.checkLoggedIn(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == true) {
                              wait().then((value) {
                                FirestoreService()
                                    .checkRegistered()
                                    .then((value) {
                                  if (value) {
                                    Navigator.of(context)
                                        .popAndPushNamed('/navigation');
                                  } else {
                                    Navigator.of(context)
                                        .popAndPushNamed('/registration');
                                  }
                                });
                              });
                              return Center(
                                child: SpinKitCircle(
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/login_email');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13,
                                          bottom: 13,
                                          left: 30,
                                          right: 30),
                                      child: Text(
                                        'Sign in with Email',
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.red[800],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/signUp_email');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13,
                                          bottom: 13,
                                          left: 30,
                                          right: 30),
                                      child: Text(
                                        'Sign up with Email',
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.red[800],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
