import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
            child: Row(
              children: <Widget>[
                Text(
                  """Featured:""",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: featured_product_images(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: Row(
              children: <Widget>[
                Text(
                  """Categories:""",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: FirestoreService().getCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return SpinKitCircle(
                  color: Colors.redAccent,
                );
              }
              return Center(
                child: Wrap(
                  children: List<Widget>.generate(
                      snapshot.data.documents.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/categoryList',
                              arguments:
                                  snapshot.data.documents[index].documentID);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width * .43,
                          width: MediaQuery.of(context).size.width * .3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width * .13,
                                backgroundColor: Colors.amber,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.documents[index].documentID
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase() +
                                      snapshot.data.documents[index].documentID
                                          .toString()
                                          .substring(1),
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          // Flexible(
          //   flex: 5,
          //   child: categories(),
          // ),
        ],
      ),
    );
  }
}

class featured_product_images extends StatefulWidget {
  @override
  _featured_product_imagesState createState() =>
      _featured_product_imagesState();
}

class _featured_product_imagesState extends State<featured_product_images> {
  int numImages = 5;
  int presentImageNumber = 1;
  List<Icon> bullets;
  List<String> featuredImages;

  @override
  Widget build(BuildContext context) {
    featuredImages = [];
    return StreamBuilder(
      stream: FirestoreService().getFeaturedProducts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SpinKitCircle(
            color: Colors.redAccent,
          );
        }
        snapshot.data.documents.forEach((product) {
          featuredImages.add(
            product.data["productImageURL"],
          );
        });

        numImages = snapshot.data.documents.length;
        bullets = [];
        for (var i = 1; i <= numImages; i++)
          if (i != presentImageNumber)
            bullets.add(
              Icon(
                Icons.brightness_1,
                size: 12.0,
                color: Colors.red.shade200,
              ),
            );
          else
            bullets.add(
              Icon(
                Icons.brightness_1,
                size: 12.0,
                color: Colors.red.shade500,
              ),
            );
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/productDisplayDetails',
                      arguments:
                          snapshot.data.documents[presentImageNumber - 1]);
                },
                child: Dismissible(
                  resizeDuration: null,
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      presentImageNumber +=
                          direction == DismissDirection.endToStart ? 1 : -1;
                      if (presentImageNumber > numImages)
                        presentImageNumber = 1;
                      else if (presentImageNumber < 1)
                        presentImageNumber = numImages;
                    });
                  },
                  key: new ValueKey(presentImageNumber),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image(
                      height: 200,
                      image:
                          NetworkImage(featuredImages[presentImageNumber - 1]),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bullets,
              ),
            ],
          ),
        );
      },
    );
  }
}

//class categories extends StatefulWidget {
//  @override
//  _categoriesState createState() => _categoriesState();
//}
//
//class _categoriesState extends State<categories> {
//  int numCategoryRows = 3;
//  int numCategoryColumns = 3;
//  List<Flexible> categoryItems = [];
//
//  @override
//  Widget build(BuildContext context) {
//    categoryItems = [];
//    categoryItems.add(
//      Flexible(
//        flex: 1,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Expanded(
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: AspectRatio(
//                          aspectRatio: 1.0,
//                          child: Icon(
//                            Icons.brightness_1,
//                            size: 70,
//                            color: Colors.purple.shade500,
//                          ),
//                        ),
//                      ),
//                    ),
//                    Text(
//                      "Category1",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(
//                        Icons.brightness_1,
//                        size: 70,
//                        color: Colors.blue.shade900,
//                      ),
//                    ),
//                    Text(
//                      "Category2",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(
//                        Icons.brightness_1,
//                        size: 70,
//                        color: Colors.yellow,
//                      ),
//                    ),
//                    Text(
//                      "Category3",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//    categoryItems.add(
//      Flexible(
//        flex: 1,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Expanded(
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: AspectRatio(
//                          aspectRatio: 1.0,
//                          child: Icon(
//                            Icons.brightness_1,
//                            size: 70,
//                            color: Colors.teal,
//                          ),
//                        ),
//                      ),
//                    ),
//                    Text(
//                      "Category4",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(
//                        Icons.brightness_1,
//                        size: 70,
//                        color: Colors.red,
//                      ),
//                    ),
//                    Text(
//                      "Category5",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(
//                        Icons.brightness_1,
//                        size: 70,
//                        color: Colors.red.shade300,
//                      ),
//                    ),
//                    Text(
//                      "Category6",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//    categoryItems.add(
//      Flexible(
//        flex: 1,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Expanded(
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: AspectRatio(
//                          aspectRatio: 1.0,
//                          child: Icon(
//                            Icons.brightness_1,
//                            size: 70,
//                            color: Colors.blue,
//                          ),
//                        ),
//                      ),
//                    ),
//                    Text(
//                      "Category7",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(
//                        Icons.brightness_1,
//                        size: 70,
//                        color: Colors.brown,
//                      ),
//                    ),
//                    Text(
//                      "Category8",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              child: FlatButton(
//                child: Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(
//                        Icons.brightness_1,
//                        size: 70,
//                        color: Colors.green,
//                      ),
//                    ),
//                    Text(
//                      "Category9",
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: categoryItems,
//    );
//  }
//}
