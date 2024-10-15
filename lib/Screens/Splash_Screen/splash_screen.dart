import 'package:all_product_exam/Routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacementNamed(context, AppRoutes.instance.home);
      },
    );
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage(
            "lib/assets/logo/product.gif",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
