import 'package:flutter/material.dart';
class CustomOfferCard extends StatelessWidget {

  CustomOfferCard({
    super.key,
    required this.offerImage,
    required this.offerpercent,
    required this.offerTitle,
    this.bgColor,
    this.textColor,
  });

  final String offerImage;
  final String offerpercent;
  final String offerTitle;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final cardColor = bgColor ?? Theme.of(context).colorScheme.primary;
    final txtColor = textColor ?? Theme.of(context).colorScheme.onPrimary;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Flexible(
              flex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offerpercent,
                    style: TextStyle(
                      color: txtColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Don’t Miss',
                    style: TextStyle(
                      color: txtColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    offerTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: txtColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  offerImage,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


