import 'package:flutter/material.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

class InstructionListWidget extends StatelessWidget {
  const InstructionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Instruciiones', 
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ));
  }
}
