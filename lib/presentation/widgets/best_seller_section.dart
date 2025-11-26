import 'package:flutter/material.dart';
import '/data/models/menu_item.dart';
import '/data/services/home_services.dart';
import '../screens/deleted/constants.dart';
import '/presentation/widgets/custom_munue_card.dart';
import '/presentation/widgets/customer_container.dart';

class BestSellersSection extends StatefulWidget {
  const BestSellersSection({super.key});

  @override
  State<BestSellersSection> createState() => _BestSellersSectionState();
}

class _BestSellersSectionState extends State<BestSellersSection> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    Stream<List<MenuItem>> stream;

    // Decide which Firestore query to use based on selection
    if (selectedCategory == 'All') {
      stream = HomeServices.getMenuItems();
    } else {
      stream = HomeServices.getMenuItemsByCategory(selectedCategory);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Category Tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 10),
              _buildCategoryItem('assets/images/icons8-checked.png', 'All'),
              const SizedBox(width: 24),
              _buildCategoryItem('assets/images/burger_icon.png', 'Burger'),
              const SizedBox(width: 24),
              _buildCategoryItem('assets/images/pizza-icon.png', 'Pizza'),
              const SizedBox(width: 24),
              _buildCategoryItem('assets/images/drink_icon.png', 'Drink'),
            ],
          ),
        ),
        const SizedBox(height: 30),

        // 🔹 Firestore StreamBuilder
        StreamBuilder<List<MenuItem>>(
          stream: stream,
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
              return const Center(
                child: Text(
                  'No items found!',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
      ],
    );
  }

  // Helper to build category buttons
  Widget _buildCategoryItem(String image, String name) {
    return CustomerContainer(

      categoryImage: image,
      categoryName: name,
      isSelected: selectedCategory == name,
      onTap: () {
        setState(() {
          selectedCategory = name;
        });
      },
    );
  }
}
