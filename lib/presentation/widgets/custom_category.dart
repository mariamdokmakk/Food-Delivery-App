import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCategory extends StatelessWidget {
  CustomCategory({
    super.key,
    required this.categoryImage,
    required this.categoryName,
    this.onTap,
  });
  String categoryImage;
  String categoryName;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(categoryImage, height: 50),

          Text(
            categoryName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
