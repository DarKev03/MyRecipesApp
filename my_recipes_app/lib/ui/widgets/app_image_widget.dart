import 'package:flutter/material.dart';

class AppImageWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const AppImageWidget({super.key, this.width, this.height});
  
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "lib/assets/images/logo.png",
      width: width ?? 200,
      height: height ?? 200,
    );
  }
  
}