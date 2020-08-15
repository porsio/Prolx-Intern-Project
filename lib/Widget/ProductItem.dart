import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  const ProductItem({
    Key key,
    @required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    text: "Product Name",
                  ),
                  TextField(
                    text: "Bid Price:  100",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    text: "Status $id",
                  ),
                  TextField(
                    text: "Bid Rank:  100",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String text;
  const TextField({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
