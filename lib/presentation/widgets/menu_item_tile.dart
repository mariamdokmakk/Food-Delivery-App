import 'package:flutter/material.dart';
import '/data/models/menu_item.dart';
import '/presentation/screens/item_details_screen.dart'; // Import the model


class MenuItemTile extends StatelessWidget {
  // 1. Accept the full object instead of separate strings
  final MenuItem menuItem;

  const MenuItemTile({
    super.key,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        // 2. Use real image (with error handling)
        child: menuItem.imageUrl.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            menuItem.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => const Icon(Icons.fastfood, color: Colors.grey),
          ),
        )
            : const Icon(Icons.fastfood, color: Colors.grey),
      ),
      title: Row(
        children: [
          Expanded(
            // 3. Use real name
            child: Text(menuItem.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      // 4. Use real price
      subtitle: Text('\$${menuItem.price}', style: const TextStyle(color: Colors.grey)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // 5. Pass the data to the next screen
            builder: (context) => itemDetailsScreen(menuItem: menuItem),
          ),
        );
      },
    );
  }
}