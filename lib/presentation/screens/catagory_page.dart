
import 'package:flutter/material.dart';
import '/data/models/menu_item.dart';
import '/data/services/home_services.dart';
import '/presentation/widgets/constants.dart';
import '/presentation/widgets/custom_munue_card.dart';


class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          categoryName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<List<MenuItem>>(
        stream: HomeServices.getMenuItemsByCategory(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryGreen),
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
                style: const TextStyle(fontSize: 16, color: Colors.grey),
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
