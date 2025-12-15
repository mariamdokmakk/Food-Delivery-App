import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Payment Methods',style: TextStyle(color: Theme.of(context).iconTheme.color),),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Open Card Scanner
            },
            icon: Icon(Icons.qr_code_scanner,color: Theme.of(context).iconTheme.color),
          ),
        ],
      ),
      // "Add New Card" Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Navigate to Add Card Screen
          },
          child: const Text('Add New Card'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildPaymentTile(
                context,
                name: 'PayPal',
                icon: Icons.paypal, // Placeholder icon
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 16),
              _buildPaymentTile(
                context,
                name: 'Google Pay',
                icon: Icons.g_mobiledata, // Placeholder icon
                iconColor: Colors.red,
              ),
               SizedBox(height: 16),
              _buildPaymentTile(
                context,
                name: 'Apple Pay',
                icon: Icons.apple,
                iconColor: Theme.of(context).iconTheme.color!,
              ),
              const SizedBox(height: 16),
              _buildPaymentTile(
                context,
                name: '•••• •••• •••• 4679',
                icon: Icons.credit_card,
                iconColor: Colors.orange,
                subtitle: 'MasterCard',
              ),
              const SizedBox(height: 16),
              _buildPaymentTile(
                context,
                name: '•••• •••• •••• 2766',
                icon: Icons.credit_card,
                iconColor: Colors.orange,
                subtitle: 'MasterCard',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentTile(BuildContext context,
      {required String name,
        required IconData icon,
        required Color iconColor,
        String? subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
              ],
            ),
          ),
          Text(
            'Connected',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}