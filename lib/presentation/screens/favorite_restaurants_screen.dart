import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/data/models/menu_item.dart';
import '/data/services/favourite_services.dart';
import '/presentation/widgets/menu_item_tile.dart';

class FavoriteRestaurantsScreen extends StatelessWidget {
  const FavoriteRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid; // get logged user
    final favService = FavoriteServices();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title:  Text('My Favorites',style: TextStyle(color: Theme.of(context).iconTheme.color)),
        actions: [
          IconButton(
            onPressed: () {},
            icon:  Icon(Icons.search,color: Theme.of(context).iconTheme.color),
          ),
        ],
      ),

      body: StreamBuilder<List<MenuItem>>(
        stream: favService.favoritesMenuItemsStream(userId),
        builder: (context, snapshot) {
          // --- Loading ---
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // --- Error ---
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading favorites"));
          }

          // --- Empty ---
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.red),
                   SizedBox(height: 16),
                  Text("No favorites yet!", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                ],
              ),
            );
          }

          // --- Success ---
          final favorites = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
              return MenuItemTile(menuItem: favorites[index]);
            },
          );
        },
      ),
    );
  }
}
