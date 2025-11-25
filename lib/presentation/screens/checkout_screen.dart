import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/data/models/cart_item.dart';

import '/data/services/cart_services.dart';
import '/data/services/user_services.dart';

import '/presentation/screens/order_successful_screen.dart';
import '/presentation/screens/payment_methods_screen.dart';

import '/presentation/screens/select_address_screen.dart';
import '/presentation/screens/offers_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map<String, dynamic>? _selectedAddress;
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<CartItem>>(
      stream: CartServices.getAllCartItems(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(child: Text("Something went wrong!")));
        }

        final cartItems = snapshot.data ?? [];

        double subtotal = 0;
        for (var item in cartItems) {
          subtotal += (item.price * item.quantity);
        }
        const double deliveryFee = 2.00;
        final double total = subtotal > 0 ? subtotal + deliveryFee : 0.0;

        // If no address selected, display "Add Address"
        // String addressLabel =
        // _selectedAddress != null ? _selectedAddress!['label'] ?? 'Address' : 'Select Address ';


        String orderAddress =
        _selectedAddress != null ? _selectedAddress!['description'] ?? 'Unknown location' : '';

        bool isPlaceOrderEnabled =
            cartItems.isNotEmpty && _selectedAddress != null;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Checkout Orders',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),

          // Bottom Order Button
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: isPlaceOrderEnabled ? () async {
                  try {
                    final userId = UserServices.getCurrentUser();
                    final firestore = FirebaseFirestore.instance;
                    final docRef = firestore
                        .collection('users')
                        .doc(userId)
                        .collection('Orders')
                        .doc();
                    final Id = docRef.id;
                    final orderData = {
                      'id': Id,
                      'userId': userId,
                      'orderId': '',
                      'address': orderAddress,
                      'totalPrice': total,
                      'orderState': 'pending',
                      'createdAt': Timestamp.now(),
                      'items': cartItems.map((item) => {
                        'id': item.id,
                        'name': item.name,
                        'price': item.price,
                        'quantity': item.quantity,
                        'image_url': item.imageUrl,
                      }).toList(),
                    };

                    await firestore
                        .collection('users')
                        .doc(userId)
                        .collection('Orders')
                        .doc(Id)
                        .set(orderData);

                    final cartSnap = await firestore
                        .collection('users')
                        .doc(userId)
                        .collection('Cart')
                        .get();

                    for (var doc in cartSnap.docs) {
                      await doc.reference.delete();
                    }

                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const OrderSuccessfulScreen()),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Order failed: $e")));
                  }
                }:null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isPlaceOrderEnabled ? Colors.green : Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  'Place Order - \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Deliver to
                  const Text('Deliver to',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.1)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(0.1),
                        child: const Icon(Icons.location_on, color: Colors.green),
                      ),
                      title: Text(_selectedAddress?['label'] ?? 'Select Address',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(orderAddress),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        // Navigate to SelectAddressScreen and wait for result
                        final result = await Navigator.push<Map<String, dynamic>>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectAddressScreen()),
                        );
                        if (result != null) {
                          setState(() {
                            _selectedAddress = result;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Order Summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Order Summary',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),

                    ],
                  ),
                  const SizedBox(height: 16),

                  // Cart Items List
                  if (cartItems.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text("Cart is empty")),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.withOpacity(0.2))),
                          child: Row(
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/burger_image.jpeg',
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Name & Price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                    Text("\$${item.price}",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),

                              // Quantity Badge & Edit Icon
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green.withOpacity(0.15),
                                    ),
                                    child: Text("${item.quantity}x",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit,
                                        color: Colors.green),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 24),

                  // Payment + Discount
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet,
                        color: Colors.green),
                    title: const Text("Payment Methods"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const PaymentMethodsScreen())),
                  ),
                   Divider(color: Colors.grey[500],),
                  ListTile(
                    leading:
                    const Icon(Icons.local_offer, color: Colors.green),
                    title: const Text("Get Discounts"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const OffersScreen())),
                  ),

                  const SizedBox(height: 24),

                  // Price Summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text('Subtotal'), Text('\$${subtotal.toStringAsFixed(2)}')],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text('Delivery Fee'), Text('\$${deliveryFee.toStringAsFixed(2)}')],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('\$${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}