import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
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
          ),
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: featured_product_images(),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
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
          ),
          Flexible(
            flex: 5,
            child: categories(),
          ),
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
  int numImages = 8;
  int presentImageNumber = 1;
  List<Icon> bullets;

  @override
  Widget build(BuildContext context) {
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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Dismissible(
            resizeDuration: null,
            onDismissed: (DismissDirection direction) {
              setState(() {
                presentImageNumber +=
                direction == DismissDirection.endToStart ? 1 : -1;
                if (presentImageNumber > 8)
                  presentImageNumber = 1;
                else if (presentImageNumber < 1) presentImageNumber = 8;
              });
            },
            key: new ValueKey(presentImageNumber),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image(
                height: 200,
                image: AssetImage(
                    "images/featured_products/image$presentImageNumber.jpg"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bullets,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class categories extends StatefulWidget {
  @override
  _categoriesState createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  int numCategoryRows = 3;
  int numCategoryColumns = 3;
  List<Flexible> categoryItems = [];

  @override
  Widget build(BuildContext context) {
    categoryItems = [];
    categoryItems.add(
      Flexible(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Icon(
                            Icons.brightness_1,
                            size: 70,
                            color: Colors.purple.shade500,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Category1",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.brightness_1,
                        size: 70,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    Text(
                      "Category2",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.brightness_1,
                        size: 70,
                        color: Colors.yellow,
                      ),
                    ),
                    Text(
                      "Category3",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    categoryItems.add(
      Flexible(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Icon(
                            Icons.brightness_1,
                            size: 70,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Category4",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.brightness_1,
                        size: 70,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Category5",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.brightness_1,
                        size: 70,
                        color: Colors.red.shade300,
                      ),
                    ),
                    Text(
                      "Category6",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    categoryItems.add(
      Flexible(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Icon(
                            Icons.brightness_1,
                            size: 70,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Category7",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.brightness_1,
                        size: 70,
                        color: Colors.brown,
                      ),
                    ),
                    Text(
                      "Category8",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.brightness_1,
                        size: 70,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      "Category9",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categoryItems,
    );
  }
}
