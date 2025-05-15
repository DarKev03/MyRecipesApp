import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class CustomElevatedButtomWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;
  final double? width;
  final double? height;

  const CustomElevatedButtomWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.textSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          padding: EdgeInsets.symmetric(
              horizontal: width ?? 32, vertical: height ?? 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: textSize ?? 16,
          ),
        ),
      ),
    );
  }
}
