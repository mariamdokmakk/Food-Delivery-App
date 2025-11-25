

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // No border
        ),
      ),
    );
  }
}