import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/SplashScreen.dart';

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