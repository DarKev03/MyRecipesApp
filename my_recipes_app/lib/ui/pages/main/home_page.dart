import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              const Text(
                'Welcome to My Recipes App',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
          
              //Carrusel de imagenes
          
              SizedBox(
                height: 30,
              ),
          
              Text(
                'Recetas favoritas',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              // Cards de recetas favoritas
            ],
          ),
        ));
  }
}
