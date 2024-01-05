// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';

import '../presentation/user/screens/chat/widget/widgets.dart';
import '../presentation/user/screens/screen.dart';
class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    log('This Route is ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case AddScreen.routeName:
        return AddScreen.route();
      case ChatScreen.routeName:
        return ChatScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case ReportScreen.routeName:
        return ReportScreen.route();
      case SingleChatScreen.routeName:
        return SingleChatScreen.route();
      // case PoliceScreen.routeName:
      //   return PoliceScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      ),
    );
  }
}
