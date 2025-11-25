import 'package:flutter/material.dart';
import '/presentation/screens/checkout_screen.dart';
import '/presentation/screens/offers_screen.dart';
import '/presentation/screens/rating_reviews_screen.dart';
import '/presentation/screens/restaurant_info_screen.dart';
import '/presentation/widgets/section_header.dart';
// 1. Navigation Imports 

// 2. Data & Services Imports
import '/data/models/resturant.dart';
import '/data/services/home_services.dart';
import '/data/models/menu_item.dart';
import '/presentation/widgets/menu_item_tile.dart';


class RestaurantDetailsScreen extends StatelessWidget {
  final Resturant restaurant;
  const RestaurantDetailsScreen({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- 1. Header with Image & Actions ---
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(restaurant.name),
              background: Container(
                color: Colors.grey[800],
                // If your model has an image URL later, uncomment this:
                // child: Image.network(restaurant.imageUrl, fit: BoxFit.cover),
              ),
              titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to favorites!")),
                  );
                },
                icon: const Icon(Icons.favorite_border, color: Colors.white),
              ),

              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sharing restaurant...")),
                  );
                },
                icon: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),

          // --- 2. Main Content ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Restaurant Info Rows ---
                  Column(
                    children: [
                      // Reviews Link
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.star, color: Colors.amber),
                        title: Row(
                          children: [
                            Text(
                              '${restaurant.rate}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            const Text('(4.8k reviews)'),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RatingReviewsScreen()),
                          );
                        },
                      ),
                      const Divider(),

                      // Info / Map Link
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                        title: const Row(
                          children: [
                            Text('2.4 km'),
                            SizedBox(width: 8),
                            Text('|'),
                            SizedBox(width: 8),
                            Text('Delivery Now'),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RestaurantInfoScreen()),
                          );
                        },
                      ),
                      const Divider(),

                      // Offers Link
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.local_offer, color: Theme.of(context).primaryColor),
                        title: Text(
                          restaurant.offers_available ? 'Offers are available' : 'No offers currently',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OffersScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- "For You" Section (Static Placeholder) ---
                  const SectionHeader(title: 'For You'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(child: Text("Item")),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- "Menu" Section (REAL DATA from Firebase) ---
                  const SectionHeader(title: 'Menu'),
                  const SizedBox(height: 16),

                  StreamBuilder<List<MenuItem>>(
                    stream: HomeServices.getMenuItems(),
                    builder: (context, snapshot) {
                      // 1. Loading
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      // 2. Error
                      if (snapshot.hasError) {
                        return const Center(child: Text("Error loading menu"));
                      }
                      // 3. Empty
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No items available"));
                      }

                      // 4. Success
                      final menuItems = snapshot.data!;

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(), // Let the page scroll
                        itemCount: menuItems.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          // Pass the real item to the tile
                          return MenuItemTile(menuItem: menuItems[index]);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // --- Bottom Bar ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutScreen()),
            );
          },
          child: const Text('View Basket'),
        ),
      ),
    );
  }
}