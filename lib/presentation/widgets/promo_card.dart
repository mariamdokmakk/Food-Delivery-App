// lib/presentation/widgets/promo_card.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class PromoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isClaimed;

  const PromoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.isClaimed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // 1. Icon
            CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 16),

            // 2. Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // 3. Claim Button
            ElevatedButton(
              onPressed: isClaimed ? null : () {
                // TODO: Add claim logic
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(80, 36), // Smaller button
                backgroundColor: isClaimed
                    ? Colors.grey.shade200
                    : Theme.of(context).primaryColor.withOpacity(0.1),
                foregroundColor: isClaimed
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                elevation: 0,
              ),
              child: Text(isClaimed ? 'Claimed' : 'Claim'),
            ),
          ],
        ),
      ),
    );
  }
}