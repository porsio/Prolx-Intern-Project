import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final String cat;
  const CategoryList({Key key, this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(cat),
      backgroundColor: Colors.redAccent,
    ));
  }
}
