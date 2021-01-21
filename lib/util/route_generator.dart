import 'package:QwikChat/pages/main_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String route = settings.name.toLowerCase();
    switch (route) {
      case '/':
        return MaterialPageRoute(builder: (context) => MainPage());
        break;
      default:
        return MaterialPageRoute(
            builder: (context) => Container(
                  child: Center(
                    child: Text("This is an error page"),
                  ),
                ));
        break;
    }
  }
}
