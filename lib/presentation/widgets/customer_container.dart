import 'package:flutter/material.dart';
import '/presentation/widgets/constants.dart';

class CustomerContainer extends StatelessWidget {
  final String categoryImage;
  final String categoryName;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomerContainer({
    Key? key,
    required this.categoryImage,
    required this.categoryName,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? primaryGreen : Colors.white,
          border: Border.all(color: primaryGreen),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.asset(categoryImage, height: 20, width: 20),
            const SizedBox(width: 5),
            Text(
              categoryName,
              style: TextStyle(
                color: isSelected ? Colors.white : primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
