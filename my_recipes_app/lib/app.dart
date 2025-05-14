import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/splash_screen_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyRecipes',
      home: SplashScreen(),
    );
  }
}