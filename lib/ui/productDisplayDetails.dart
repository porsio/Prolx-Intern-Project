import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayProductDetails extends StatelessWidget {
  final product;
  const DisplayProductDetails({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Prolx'),
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    product.data["Product Name"],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image(
                fit: BoxFit.fitWidth,
                width: double.infinity,
                image: NetworkImage(product.data["productImageURL"]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text("\u{20B9}"),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      product.data["price"].toString(),
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Row(
//                children: <Widget>[
//                  Text(
//                    "Product Name: ",
//                    style: TextStyle(
//                      fontSize: 20.0,
//                      fontStyle: FontStyle.italic,
//                    ),
//                  ),
//                  Text(
//                    product.data["Product Name"],
//                    style: TextStyle(
//                      fontSize: 20.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                ],
//              ),
//            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Category: ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    product.data["category"],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Expires on: ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    product.data["Product Expiry"].toDate().toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60.0,
                width: 150.0,
                child: PlaceABidIcon(),
              ),
            ),
          ],
        ));
  }
}

class PlaceABidIcon extends StatefulWidget {
  @override
  _PlaceABidIconState createState() => _PlaceABidIconState();
}

class _PlaceABidIconState extends State<PlaceABidIcon> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      child: Text(
        "Place a Bid",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      color: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}
