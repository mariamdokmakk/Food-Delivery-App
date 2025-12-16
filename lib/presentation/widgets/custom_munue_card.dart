

import 'package:flutter/material.dart';
import '/data/models/menu_item.dart';
import '/data/services/favourite_services.dart';

class CustomMunueCard extends StatefulWidget {
  final String foodName;
  final String foodImage;
  final String foodDetails;

  // 🔹 keep it to avoid breaking other screens
  final String? foodPrice; // NOT USED

  final MenuItem menuItem;
  final VoidCallback? onTap;

  const CustomMunueCard({
    Key? key,
    required this.foodName,
    required this.foodImage,
    required this.foodDetails,
    this.foodPrice, // optional
    required this.menuItem,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomMunueCard> createState() => _CustomMunueCardState();
}

class _CustomMunueCardState extends State<CustomMunueCard> {
  bool _isNetworkImage(String? path) {
    if (path == null || path.isEmpty) return false;
    final lower = path.toLowerCase();
    return lower.startsWith('http://') || lower.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.menuItem;

    final double originalPrice = item.price.toDouble();
    final double finalPrice =
    item.newPrice != 0 ? item.newPrice.toDouble() : originalPrice;
    final bool hasOffer = item.newPrice != 0;

    Widget imageWidget;
    if (_isNetworkImage(widget.foodImage)) {
      imageWidget = Image.network(
        widget.foodImage,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          'assets/images/food.jpg',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      );
    } else {
      imageWidget = Image.asset(
        'assets/images/food.png',
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    }

    return InkWell(
      onTap: widget.onTap,
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: imageWidget,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.foodName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.foodDetails,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        hasOffer
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${originalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                decoration:
                                TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              '\$${finalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                            : Text(
                          '\$${finalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        // ❤️ FAVORITE
                        ValueListenableBuilder<List<String>>(
                          valueListenable:
                          FavoriteServices.favoriteIds,
                          builder: (context, favs, _) {
                            final isFavorite =
                            favs.contains(item.id);

                            return IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                isFavorite ? Colors.red : null,
                              ),
                              onPressed: () async {
                                await FavoriteServices
                                    .toggleFavorite(item);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


