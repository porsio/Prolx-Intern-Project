import 'package:flutter/material.dart';
import '../Widget/ProductItem.dart';

class ExpandedPanel extends StatefulWidget {
  ExpandedPanel({Key key}) : super(key: key);

  @override
  _ExpandedPanel createState() => _ExpandedPanel();
}

class _ExpandedPanel extends State<ExpandedPanel> {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      initialOpenPanelValue: 2,
      children: entries.map<ExpansionPanelRadio>((String item) {
        return ExpansionPanelRadio(
          value: item,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ProductItem(
              id: item,
            );
          },
          body: BuildExpandedPanel(),
        );
      }).toList(),
    );
  }
}

class BuildExpandedPanel extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [Text("PERSON 1"), Text("Person 2")],
          )
        ],
      ),
    );
  }
}
