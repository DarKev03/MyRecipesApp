import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController controller;
  final bool? obscureText;
  final bool? enableSuggestions;
  final String? labelText;
  final Color? color;
  const CustomTextField(
      {super.key,
      this.keyboardType,
      this.maxLength,
      required this.controller,
      this.obscureText,
      this.enableSuggestions,
      this.labelText,
      this.color});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: enableSuggestions ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLength: maxLength,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color ?? AppColors.primaryColor,
            width: 1,
          ),          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color ?? AppColors.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
