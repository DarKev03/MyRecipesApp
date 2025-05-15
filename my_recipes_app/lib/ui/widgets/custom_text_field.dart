import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController controller;
  final bool? isPassword;
  final bool? enableSuggestions;
  final String? labelText;
  final Color? color;
  const CustomTextField(
      {super.key,
      this.keyboardType,
      this.maxLength,
      required this.controller,
      required this.isPassword,
      this.enableSuggestions,
      this.labelText,
      this.color});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: widget.enableSuggestions ?? false,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLength: widget.maxLength,
      controller: widget.controller,
      obscureText: widget.isPassword == true ? _isObscured : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.color ?? AppColors.primaryColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.color ?? AppColors.primaryColor,
            width: 2,
          ),
        ),
        suffixIcon: widget.isPassword != false
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon:
                    Icon(_isObscured ? Icons.visibility_off : Icons.visibility))
            : null,
      ),
    );
  }
}
