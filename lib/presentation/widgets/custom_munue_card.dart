import 'package:flutter/material.dart';
import '/data/models/menu_item.dart';
import '/data/services/favourite_services.dart';
import '/presentation/widgets/constants.dart';


class CustomMunueCard extends StatefulWidget {

  final String foodName;
  final String foodImage;
  final String foodDetails;
  final String foodPrice;
  final MenuItem? menuItem;

  const CustomMunueCard({
    Key? key,
    required this.foodName,
    required this.foodImage,
    required this.foodDetails,
    required this.foodPrice,
    required this.menuItem,
  }) : super(key: key);

  @override
  State<CustomMunueCard> createState() => _CustomMunueCardState();
}

class _CustomMunueCardState extends State<CustomMunueCard> {
  // bool isFavorite = false;
  // bool _loadingFavStatus = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _initFavorite();
  // }

  // void _initFavorite() {
  //   final menuItem = widget.menuItem;
  //   if (menuItem != null) {
  //     _loadingFavStatus = true;
  //     FavoritesService.isFavorite(menuItem.id)
  //         .then((fav) {
  //           if (mounted) {
  //             setState(() {
  //               isFavorite = fav;
  //               _loadingFavStatus = false;
  //             });
  //           }
  //         })
  //         .catchError((_) {
  //           if (mounted) {
  //             setState(() => _loadingFavStatus = false);
  //           }
  //         });
  //   }
  // }



  // void _initFavorite() {
  //   final menuItem = widget.menuItem;
  //   if (menuItem != null) {
  //     setState(() => _loadingFavStatus = true);
  //
  //     // Call the static method using the class name
  //     FavoriteServices.isFavorite(menuItem.id).then((fav) {
  //       if (mounted) {
  //         setState(() {
  //           isFavorite = fav;
  //           _loadingFavStatus = false;
  //         });
  //       }
  //     }).catchError((_) {
  //       if (mounted) setState(() => _loadingFavStatus = false);
  //     });
  //   }
  // }

  bool _isNetworkImage(String path) {
    final lower = path.toLowerCase();
    return lower.startsWith('http://') || lower.startsWith('https://');
  }

  // Future<void> _onFavoritePressed() async {
  //   setState(() => isFavorite = !isFavorite);
  //
  //   final menuItem = widget.menuItem;
  //   if (menuItem != null) {
  //     try {
  //       await FavoriteServices.toggleFavorite(menuItem);
  //     } catch (e) {
  //       if (mounted) {
  //         setState(() => isFavorite = !isFavorite);
  //       }
  //     }
  //   } else {
  //     // no menuItem provided — no firestore update, keep local toggle only
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final itemName = widget.foodName;
    final itemDesc = widget.foodDetails;
    final itemPrice = widget.foodPrice;
    final imagePath = widget.foodImage;
    final item = widget.menuItem;

    Widget imageWidget;
    if (_isNetworkImage(imagePath)) {
      imageWidget = Image.network(
        imagePath,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/food.jpg',
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      // local asset
      imageWidget = Image.asset(
        imagePath,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    }

    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                    itemName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(itemDesc, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.delivery_dining,
                            size: 18,
                            color: primaryGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            itemPrice,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      // Favorite button
                      ValueListenableBuilder<List<String>>(
                        valueListenable: FavoriteServices.favoriteIds,
                        builder: (context, favs, _) {
                          final isFavorite = favs.contains(widget.menuItem!.id);

                          return IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                            onPressed: () async {
                              await FavoriteServices.toggleFavorite(widget.menuItem!);
                            },
                          );
                        },
                      )


                      // IconButton(
                      //   icon: _loadingFavStatus
                      //       ? const SizedBox(
                      //           width: 24,
                      //           height: 24,
                      //           child: CircularProgressIndicator(
                      //             strokeWidth: 2,
                      //           ),
                      //         )
                      //       : Icon(
                      //           isFavorite
                      //               ? Icons.favorite
                      //               : Icons.favorite_border,
                      //           color: isFavorite ? Colors.red : null,
                      //         ),
                      //   onPressed: _onFavoritePressed,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
