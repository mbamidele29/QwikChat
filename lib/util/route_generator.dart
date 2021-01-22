import 'package:QwikChat/pages/chat_page.dart';
import 'package:QwikChat/pages/chats_page.dart';
import 'package:QwikChat/pages/error_page.dart';
import 'package:QwikChat/pages/main_page.dart';
import 'package:QwikChat/pages/signup_page.dart';
import 'package:QwikChat/pages/users_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String route = settings.name.toLowerCase();
    switch (route) {
      case '/':
        return MaterialPageRoute(builder: (context) => MainPage());
        break;
      case '/signup':
        return MaterialPageRoute(builder: (context) => SignupPage());
        break;
      case '/chats':
        return MaterialPageRoute(builder: (context) => ChatsPage());
        break;
      case '/users':
        return MaterialPageRoute(builder: (context) => UsersPage());
        break;
      case '/chat':
        return MaterialPageRoute(
            settings: settings, builder: (context) => ChatPage());
        break;
      default:
        return MaterialPageRoute(builder: (context) => ErrorPage());
        break;
    }
  }
}
