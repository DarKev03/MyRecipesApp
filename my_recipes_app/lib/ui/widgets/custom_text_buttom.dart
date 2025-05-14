import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class CustomTextButtom extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final VoidCallback onPressed;

  const CustomTextButtom({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize ?? 16,
          color: textColor ?? AppColors.secondaryColor,
        ),
      ),
    );
  }
}
