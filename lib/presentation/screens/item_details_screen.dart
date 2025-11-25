import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/favourite_services.dart';
// Data & Services
import '/data/models/menu_item.dart';
import '/data/services/item_details_services.dart';
import '/data/services/home_services.dart'; // For favorites

class itemDetailsScreen extends StatefulWidget {
  final MenuItem menuItem;

  const itemDetailsScreen({
    super.key,
    required this.menuItem,
  });

  @override
  State<itemDetailsScreen> createState() => _itemDetailsScreenState();
}

class _itemDetailsScreenState extends State<itemDetailsScreen> {
  int _quantity = 1;
  final TextEditingController _noteController = TextEditingController();
  bool _isLoading = false;
  bool _isFav=false; // Local state for favorite toggling

  @override
  void initState() {
    super.initState();
    // _isFav = widget.menuItem.isFav;
  }

  // Logic to Add to Cart
  Future<void> _addToBasket() async {
    setState(() => _isLoading = true);

    try {

      await ItemDetailsServices().addToCart(
        widget.menuItem,
        _quantity,
        _noteController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${_quantity}x ${widget.menuItem.name} added to cart!"),
            backgroundColor: Theme.of(context).primaryColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add to cart: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final num totalPrice = widget.menuItem.price * _quantity;

    return Scaffold(
      // --- BOTTOM BUTTON (Rounded) ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0), // More padding for floating look
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _addToBasket,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Pill shape
              ),
              elevation: 4,
            ),
            child: _isLoading
                ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
            )
                : Text(
              'Add to Basket - \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Header Image & Back Button ---
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    widget.menuItem.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.fastfood, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),

                // Safe Area for Buttons
                Positioned(
                  top: 0, left: 0, right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: const BackButton(color: Colors.black),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child:
                            ValueListenableBuilder<List<String>>(
                              valueListenable: FavoriteServices.favoriteIds,
                              builder: (context, favs, _) {
                                final isFavorite = favs.contains(widget.menuItem!.id);
                                return IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Theme.of(context).disabledColor,
                                  ),
                                  onPressed: () async {
                                    await FavoriteServices.toggleFavorite(widget.menuItem!);
                                  },
                                );
                              },
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // --- 2. Item Info ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.menuItem.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.menuItem.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
                  ),
                  const SizedBox(height: 32),

                  // Quantity Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildQuantityBtn(
                        icon: Icons.remove,
                        onTap: () {
                          if (_quantity > 1) setState(() => _quantity--);
                        },
                        isColor: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          '$_quantity',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildQuantityBtn(
                        icon: Icons.add,
                        onTap: () {
                          setState(() => _quantity++);
                        },
                        isColor: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Note Input (Using Theme Style)
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintText: 'Note to Restaurant (optional)',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.08), // Translucent
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Quantity Buttons
  Widget _buildQuantityBtn({required IconData icon, required VoidCallback onTap, required bool isColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isColor ? Theme.of(context).primaryColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          color: isColor ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}