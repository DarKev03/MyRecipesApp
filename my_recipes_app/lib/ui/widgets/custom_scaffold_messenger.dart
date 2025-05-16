// lib/utils/custom_snackbar.dart
import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
