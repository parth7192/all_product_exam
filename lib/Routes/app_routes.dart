import 'package:all_product_exam/Screens/Cart_Page/cart_page.dart';
import 'package:all_product_exam/Screens/Home_Page/home_page.dart';
import 'package:all_product_exam/Screens/Splash_Screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();

  String splash = '/';
  String home = 'home_page';
  String cart = 'cart_page';

  Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const SplashScreen(),
    'home_page': (context) => HomePage(),
    'cart_page': (context) => CartPage(),
  };
}
