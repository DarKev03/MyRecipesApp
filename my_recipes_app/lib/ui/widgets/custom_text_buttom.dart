import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class CustomTextButtom extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final VoidCallback onPressed;

  const CustomTextButtom({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,        
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize ?? 16,
            color: textColor ?? AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
