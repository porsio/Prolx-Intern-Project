import 'package:Prolx/ui/categoryList.dart';
import 'package:Prolx/ui/navigation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/navigation':
        return MaterialPageRoute(
          builder: (_) => Navigation(),
        );
      case '/categoryList':
        return MaterialPageRoute(
          builder: (_) => CategoryList(
            cat: args,
          ),
        );
      // case '/main_screen':
      //   return MaterialPageRoute(
      //     builder: (_) => MainScreen(),
      //   );
      // case '/description':
      //   return MaterialPageRoute(
      //     builder: (_) => Description(productId: args),
      //   );

      // If args is not of the correct type, return an error page.
      default:
        return _errorRoute();
    }
  }

  static Route<void> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('/'),
        ),
        body: Center(
          child: Text('/'),
        ),
      );
    });
  }
}
