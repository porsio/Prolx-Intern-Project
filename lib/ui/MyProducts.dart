import 'package:flutter/material.dart';
import '../Widget/ProductExpanded.dart';

class MyProducts extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {print("PRESSED")},
        child: Icon(Icons.add_circle_outline),
      ),
      body: ExpandedPanel(),
    );
  }
}
