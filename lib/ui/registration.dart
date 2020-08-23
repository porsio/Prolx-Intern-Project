import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'drawerWidget.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerWidget(),
      body: RegistrationInput(),
    );
  }
}

class RegistrationInput extends StatefulWidget {
  @override
  _RegistrationInputState createState() => _RegistrationInputState();
}

class _RegistrationInputState extends State<RegistrationInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool sheetVisisble = true;
  String name = '';
  String mobileNo = '';

  changeVisible() {
    setState(() {
      if (sheetVisisble) {
        sheetVisisble = false;
      } else {
        sheetVisisble = true;
      }
    });
  }

  void _showAlertDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'Invalid Input',
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

  done(
    String name,
    String mobileNo,
  ) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pushNamed('/loading');
      try {
        FirestoreService().updateUser(name, mobileNo).then((value) {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/navigation', (Route<dynamic> route) => false);
        });
      } catch (e) {
        print(e);
        Navigator.of(context).pop();
        _showAlertDialog(context);
      }
    }
    /* else {
      Navigator.of(context).pop();
      _showAlertDialog(context);
    } */
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
        child: Visibility(
          visible: sheetVisisble,
          replacement: SpinKitChasingDots(color: Colors.red),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.control_point),
                      SizedBox(width: 10),
                      Text('Enter Name'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      initialValue: name,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                      },
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.control_point),
                      SizedBox(width: 10),
                      Text('Enter Mobile No.'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: mobileNo,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Mobile Number';
                        }
                        if (value.length != 10) {
                          return 'Enter 10 digit Mobile Number';
                        } else
                          return null;
                      },
                      onChanged: (value) {
                        mobileNo = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'XXXXXXXXXX',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ActionChip(
                      elevation: 10,
                      backgroundColor: Colors.redAccent,
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        done(
                          name,
                          mobileNo,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
