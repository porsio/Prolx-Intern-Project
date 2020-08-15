import 'package:flutter/material.dart';
import '../Widget/ProductItem.dart';

class MyBids extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 120,
              padding: EdgeInsets.only(bottom: 20),
              child: ProductItem(id: entries[index]));
        });
  }
}
