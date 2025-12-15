import 'package:flutter/material.dart';
import '/data/models/cart_item.dart';
import '/data/services/cart_services.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).textTheme.bodyMedium!.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Theme.of(context).textTheme.bodyMedium!.color),
            onPressed: () async {
              await CartServices.clearCart();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: CartServices.getAllCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
              child: CircularProgressIndicator(color:Theme.of(context).colorScheme.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final cartItems = snapshot.data ?? [];

          if (cartItems.isEmpty) {
            return Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 100, color: Theme.of(context).colorScheme.primary),
                  SizedBox(height: 16),
                  Text(
                    'Empty',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "You don't have any foods in your cart right now",
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 14),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    return Dismissible(
                      key: Key(item.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 30),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child:  Icon(
                          Icons.delete,
                          color: Theme.of(context).iconTheme.color,
                          size: 32,
                        ),
                      ),
                      onDismissed: (_) async {
                        await CartServices.deleteCartItem(item.id);
                      },
                      child: Container(

                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.network(
                                  item.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/food.jpg',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Theme.of(context).textTheme.bodyMedium!.color,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Quantity: ${item.quantity}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '\$${item.finalPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Checkout Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/checkout',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
