// lib/presentation/widgets/review_tile.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ReviewTile extends StatelessWidget {
  final String name;
  final String reviewText;
  final String date; // <--- FIXED
  final int likes;
  final double rating;
  // final String imageUrl; // We'll add this later

  const ReviewTile({
    super.key,
    required this.name,
    required this.reviewText,
    required this.date,
    required this.likes,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    // Define the color as a variable for clarity
    const Color grey700 = Color(0xFF616161);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            // backgroundImage: NetworkImage(imageUrl), // For later
          ),
          const SizedBox(width: 12),
          // Review Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Name, Rating, More Icon
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(' $rating', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Icon(Icons.more_horiz),
                  ],
                ),
                const SizedBox(height: 8),
                // Review Text
                Text(
                  reviewText,
                  style: const TextStyle(color: Colors.grey, height: 1.4),
                ),
                const SizedBox(height: 12),
                // Bottom Row: Likes and Date
                Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 20, color: grey700),
                    const SizedBox(width: 4),
                    Text(
                      '$likes',
                      style: const TextStyle(color: grey700, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}