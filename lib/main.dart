import 'package:flutter/material.dart';
import 'functionalities/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prolx",
      debugShowCheckedModeBanner: false,
      initialRoute: '/navigation',
      theme: ThemeData(primarySwatch: Colors.red),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
