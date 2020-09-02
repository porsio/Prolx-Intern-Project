import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Prolx/ui/productDisplayDetails.dart';

class CategoryList extends StatelessWidget {
  final String cat;
  const CategoryList({Key key, this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder(
        stream: FirestoreService().getCategoryProducts(
          cat.substring(0, 1).toUpperCase() + cat.substring(1),
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return SpinKitCircle(
              color: Colors.redAccent,
            );
          }
          return Wrap(
            children: List<Widget>.generate(
              snapshot.data.documents.length,
              (index) {
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          width: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                      child: CreateItemBar(snapshot.data.documents[index]),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CreateItemBar extends StatefulWidget {
  final dynamic product;
  CreateItemBar(this.product);

  @override
  _CreateItemBarState createState() => _CreateItemBarState(product);
}

class _CreateItemBarState extends State<CreateItemBar> {
  dynamic product;
  _CreateItemBarState(this.product);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      onPressed: () {
        Navigator.of(context)
            .pushNamed('/productDisplayDetails', arguments: product);
      },
      child: InkWell(
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image(
                image: NetworkImage(product.data["productImageURL"]),
              ),
            ),
            Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 0.0, 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            product.data["Product Name"],
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\u{20B9}" + product.data["price"].toString(),
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 0.0, 16.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Expires on: " +
                                product.data["Product Expiry"]
                                    .toDate()
                                    .toString(),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
