import 'package:flutter/material.dart';
import 'package:tyba_test/src/Orders/ui/screens/order_history_screen.dart';
import 'package:tyba_test/src/Restaurants/ui/screens/home_screen.dart';
import 'package:tyba_test/src/User/ui/screens/login_screen.dart';
import 'package:tyba_test/src/User/ui/screens/profile_screen.dart';
import 'package:tyba_test/src/User/ui/screens/register_screen.dart';
import 'package:tyba_test/src/settings/routes.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      });
    case Routes.login:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case Routes.register:
      return MaterialPageRoute(builder: (_) => RegisterScreen());
    case Routes.profile:
      return MaterialPageRoute(builder: (_) => ProfileScreen());
    case Routes.orderHistory:
      return MaterialPageRoute(builder: (_) => OrderHistory());
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
