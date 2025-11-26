
import 'package:flutter/material.dart';
import '/data/models/menu_item.dart';
import '/data/services/home_services.dart';
import 'deleted/constants.dart';
import '/presentation/widgets/custom_munue_card.dart';


class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).textTheme.bodyMedium!.color),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.bodyMedium!.color),
        title: Text(
          categoryName,
          style:  TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
      ),
      body: StreamBuilder<List<MenuItem>>(
        stream: HomeServices.getMenuItemsByCategory(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return Center(
              child: Text(
                'No $categoryName items available.',
                style: TextStyle(fontSize: 16, color: Theme.of(context).disabledColor),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CustomMunueCard(
                  foodImage: item.imageUrl,
                  foodName: item.name,
                  foodDetails: item.description,
                  foodPrice: '\$${item.price.toStringAsFixed(2)}',
                  menuItem: item,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
