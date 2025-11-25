import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/data/models/menu_item.dart';
import '/data/services/favourite_services.dart';
import '/presentation/widgets/constants.dart';

class CustomFoodCard extends StatefulWidget {
  final MenuItem item;

  const CustomFoodCard({super.key, required this.item});

  @override
  State<CustomFoodCard> createState() => _CustomFoodCardState();
}

class _CustomFoodCardState extends State<CustomFoodCard> {
  // bool isFavorite = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadFavoriteStatus();
  // }

  // Future<void> _loadFavoriteStatus() async {
  //   final fav = await FavoriteServices.isFavorite(widget.item.id);
  //   if (mounted) {
  //     setState(() => isFavorite = fav);
  //   }
  // }

  // Future<void> _toggleFavorite() async {
  //   setState(() => isFavorite = !isFavorite);
  //   await FavoriteServices.toggleFavorite(widget.item);
  // }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      elevation: 2,
      child: Container(
        width: 0.5.sw,
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
              ),
              child: Image.network(
                item.imageUrl,
                height: 140.h,
                width: 180.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/food.jpg',
                  height: 140.h,
                  width: 180.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Text(
              item.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
            Row(
              children: [
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Spacer(),
                ValueListenableBuilder<List<String>>(
                  valueListenable: FavoriteServices.favoriteIds,
                  builder: (context, favs, _) {
                    final isFavorite = favs.contains(widget.item.id);

                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () async {
                        await FavoriteServices.toggleFavorite(widget.item);
                      },
                    );
                  },
                )
                // IconButton(
                //   icon: Icon(
                //     isFavorite ? Icons.favorite : Icons.favorite_border,
                //     color: isFavorite ? Colors.red : null,
                //   ),
                //   onPressed: _toggleFavorite,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//
