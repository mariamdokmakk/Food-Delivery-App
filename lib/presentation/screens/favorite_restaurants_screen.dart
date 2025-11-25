import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// 1. Import Data & Services
import '/data/models/menu_item.dart';
import '/data/services/favourite_services.dart';
import '/presentation/widgets/menu_item_tile.dart'; // We reuse the food tile!



// class FavoriteRestaurantsScreen extends StatelessWidget {
//   const FavoriteRestaurantsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Favorites'), // Changed title to match data
//         actions: [
//           IconButton(
//             onPressed: () {
//               // TODO: Search logic
//             },
//             icon: const Icon(Icons.search),
//           ),
//         ],
//       ),
//       // 2. Listen to the Favorites Stream
//       body: StreamBuilder<List<MenuItem>>(
//         stream: FavoritesService.getFavoritesStream(),
//         builder: (context, snapshot) {
//           // --- Loading State ---
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           // --- Error State ---
//           if (snapshot.hasError) {
//             return const Center(child: Text("Error loading favorites"));
//           }
//
//           // --- Empty State ---
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
//                   const SizedBox(height: 16),
//                   const Text("No favorites yet!", style: TextStyle(color: Colors.grey)),
//                 ],
//               ),
//             );
//           }
//
//           // --- Success State ---
//           final favorites = snapshot.data!;
//
//           return ListView.separated(
//             padding: const EdgeInsets.all(16),
//             itemCount: favorites.length,
//             separatorBuilder: (context, index) => const Divider(),
//             itemBuilder: (context, index) {
//               // 3. Use MenuItemTile to display the Food
//               return MenuItemTile(menuItem: favorites[index]);
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class FavoriteRestaurantsScreen extends StatelessWidget {
  const FavoriteRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid; // get logged user
    final favService = FavoriteServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
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
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text("No favorites yet!", style: TextStyle(color: Colors.grey)),
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
