import 'package:flutter/material.dart';
import './MyBids.dart';
import './MyProducts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
              leading: Container(),
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                  unselectedLabelColor: Colors.redAccent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent),
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Colors.redAccent, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("My Bids"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Colors.redAccent, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("My Products"),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          body: TabBarView(children: [
            MyBids(),
            MyProducts(),
          ]),
        ),
      ),
    );
  }
}
