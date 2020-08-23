import 'dart:async';
import 'dart:io';
import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool sheetVisisble = true;
  List<String> categories = [];
  String prodName;
  String description;
  String price;
  List<File> images = [];
  List<String> sizes = [];
  String dropDownValue = 'beauty and health';
  final picker = ImagePicker();

  Future getImage() async {
    final tempImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 10);
    setState(() {
      images.add(File(tempImage.path));
    });
  }

  Future getImageCam() async {
    final tempImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 10);
    setState(() {
      images.add(File(tempImage.path));
    });
  }

  Future<void> _error(context, message) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: Text(
              message,
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.cancel,
                    size: 40.0,
                    color: Colors.indigo[900],
                  ))
            ],
          );
        });
  }

  changeVisible() {
    setState(() {
      if (sheetVisisble) {
        sheetVisisble = false;
      } else {
        sheetVisisble = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      margin: const EdgeInsets.only(top: 5, left: 35, right: 35),
      child: Visibility(
        visible: sheetVisisble,
        replacement: SpinKitChasingDots(color: Colors.indigo[900]),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Product',
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop())
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.control_point),
                    SizedBox(width: 10),
                    Text('Select Category'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.control_point),
                    SizedBox(width: 10),
                    Text('Enter Product Name'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    initialValue: prodName,
                    onChanged: (value) {
                      prodName = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Name';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Product Name',
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
                    Text('Enter Product Description'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Description';
                      }
                    },
                    initialValue: description,
                    maxLines: null,
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Product Description',
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
                    Text('Add Product Images'),
                  ],
                ),
              ),
              Wrap(
                runSpacing: 7,
                spacing: 5,
                children: List.generate(
                  images.length,
                  (index) {
                    return Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  images[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Positioned(
                            top: -10,
                            right: -10,
                            child: Container(
                              child: IconButton(
                                //iconSize: MediaQuery.of(context).size.width/16,
                                icon: Icon(Icons.remove_circle),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                              ),
                            ))
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ActionChip(
                      elevation: 10,
                      backgroundColor: Colors.white,
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add_a_photo),
                      ),
                      onPressed: getImageCam,
                    ),
                    SizedBox(width: 30),
                    ActionChip(
                      elevation: 10,
                      backgroundColor: Colors.white,
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add_photo_alternate),
                      ),
                      onPressed: getImage,
                    ),
                  ],
                ),
              ),
              Wrap(
                  runSpacing: 7,
                  spacing: 5,
                  children: List.generate(sizes.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.width / 10,
                            decoration: BoxDecoration(
                                color: Colors.pink[100],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(sizes[index]),
                          ),
                          Positioned(
                              top: -20,
                              right: -20,
                              child: Container(
                                child: IconButton(
                                  //iconSize: MediaQuery.of(context).size.width/16,
                                  icon: Icon(Icons.remove_circle),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      sizes.removeAt(index);
                                    });
                                  },
                                ),
                              ))
                        ],
                      ),
                    );
                  })),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.control_point),
                    SizedBox(width: 10),
                    Text('Enter product Price'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    initialValue: price,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product price';
                      }
                    },
                    onChanged: (value) {
                      price = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '\u{20B9}',
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
                      // if (_formKey.currentState.validate()) {
                      //   if (images.isEmpty) {
                      //     _error(context, 'Please add image');
                      //   } else {
                      //     changeVisible();
                      //     FirestoreService()
                      //         .newProduct(images, prodName, description, price,
                      //             dropDownValue, sizes)
                      //         .then((value) {
                      //       if (value == 1) {
                      //         Toast.show("uploaded", context,
                      //             duration: Toast.LENGTH_SHORT,
                      //             gravity: Toast.BOTTOM);
                      //         setState(() {
                      //           images.clear();
                      //         });
                      //         Navigator.of(context).pop();
                      //       } else if (value == 0) {
                      //         changeVisible();
                      //         Toast.show("something went wrong", context,
                      //             duration: Toast.LENGTH_SHORT,
                      //             gravity: Toast.BOTTOM);
                      //       }
                      //     });
                      //   }
                      // }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:Prolx/functionalities/firestoreServices.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class ProductPage extends StatefulWidget {
//   ProductPage({
//     Key key,
//   }) : super(key: key);

//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool sheetVisisble = true;
//   List<String> categories = [];
//   String categoryName;

//   changeVisible() {
//     setState(() {
//       if (sheetVisisble) {
//         sheetVisisble = false;
//       } else {
//         sheetVisisble = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       margin: const EdgeInsets.only(top: 5, left: 35, right: 35),
//       child: Visibility(
//         visible: sheetVisisble,
//         replacement: SpinKitChasingDots(color: Colors.pink[400]),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Add Product',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       IconButton(
//                           icon: Icon(Icons.close),
//                           onPressed: () => Navigator.of(context).pop())
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Icon(Icons.control_point),
//                     SizedBox(width: 10),
//                     Text('Enter Product Name'),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(30)),
//                   child: TextFormField(
//                     initialValue: categoryName,
//                     onChanged: (value) {
//                       categoryName = value;
//                     },
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Enter Product Name';
//                       }
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Product Name',
//                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                         borderSide: BorderSide(color: Colors.transparent),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: ActionChip(
//                     elevation: 10,
//                     backgroundColor: Colors.pink[400],
//                     label: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Done',
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ),
//                     onPressed: () {
//                       // if (_formKey.currentState.validate()) {
//                       //   changeVisible();
//                       //   FirestoreService()
//                       //       .addProduct(categoryName, id)
//                       //       .then((value) {
//                       //     if (value == 1) {
//                       //       Scaffold.of(context).showSnackBar(
//                       //         SnackBar(
//                       //           content: Text('updated!!'),
//                       //         ),
//                       //       );

//                       //       Navigator.of(context).pop();
//                       //     } else if (value == 0) {
//                       //       changeVisible();
//                       //       Scaffold.of(context).showSnackBar(
//                       //         SnackBar(
//                       //           content: Text('Something went wrong!'),
//                       //         ),
//                       //       );
//                       //       Navigator.of(context).pop();
//                       //     }
//                       //   });
//                       // }
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';

// // class ProductPage extends StatefulWidget {
// //   ProductPage({Key key}) : super(key: key);

// //   @override
// //   _ProductPageState createState() => _ProductPageState();
// // }

// // class _ProductPageState extends State<ProductPage> {
// //   Widget _nameTextField() {
// //     return Material(
// //       elevation: 10.0,
// //       shadowColor: Colors.black,
// //       child: TextField(
// //         keyboardType: TextInputType.text,
// //         decoration: InputDecoration(
// //             border:
// //                 OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
// //       ),
// //     );
// //   }

// //   Widget _descriptionTextField() {
// //     return Material(
// //       elevation: 10.0,
// //       shadowColor: Colors.black,
// //       child: TextField(
// //         keyboardType: TextInputType.text,
// //         maxLines: 20,
// //         decoration: InputDecoration(
// //             border:
// //                 OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
// //       ),
// //     );
// //   }

// //   var _image;
// //   Future getImage() async {
// //     final image = await ImagePicker.pickImage(source: ImageSource.camera);
// //     setState(() {
// //       _image = image;
// //     });
// //   }

// //   Widget _addphotoTextField() {
// //     return Material(
// //       elevation: 10.0,
// //       shadowColor: Colors.black,
// //       child: TextField(
// //         decoration: InputDecoration(
// //             prefixIcon:
// //                 IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
// //             border:
// //                 OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
// //       ),
// //     );
// //   }

// //   Widget _askpriceTextField() {
// //     return Material(
// //       elevation: 10.0,
// //       shadowColor: Colors.black,
// //       child: TextField(
// //         keyboardType: TextInputType.number,
// //         decoration: InputDecoration(
// //             border:
// //                 OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: MediaQuery.of(context).size.height,
// //       child: ListView(
// //         padding: EdgeInsets.all(8),
// //         children: <Widget>[
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text(
// //                   'Add Product',
// //                   style: TextStyle(fontSize: 18),
// //                 ),
// //               ),
// //               IconButton(
// //                   icon: Icon(Icons.close),
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                   })
// //             ],
// //           ),
// //           ListTile(
// //             title: Text("Name"),
// //           ),
// //           _nameTextField(),
// //           ListTile(
// //             title: Text("Description"),
// //           ),
// //           _descriptionTextField(),
// //           ListTile(
// //             title: Text("Add photos"),
// //           ),
// //           _addphotoTextField(),
// //           ListTile(
// //             title: Text("Ask Price"),
// //           ),
// //           _askpriceTextField(),
// //           SizedBox(
// //             height: 100,
// //           ),
// //           RaisedButton(
// //               child: Text(
// //                 "Auction it",
// //                 style: TextStyle(color: Colors.redAccent),
// //               ),
// //               onPressed: null,
// //               shape: new RoundedRectangleBorder(
// //                 borderRadius: new BorderRadius.circular(35.0),
// //               ))
// //         ],
// //       ),
// //     );
// //   }
// // }
