import 'package:flutter/material.dart';
import '../widgets/constants.dart'; 

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'icon': Icons.cancel,
        'iconColor': Colors.redAccent,
        'title': 'Orders Cancelled!',
        'date': '19 Dec, 2022 | 20:50 PM',
        'desc':
            'You have canceled an order at Burger Hut. We apologize for your inconvenience. We will try to improve our service next time 🥲',
        'isNew': true,
      },
      {
        'icon': Icons.shopping_bag_outlined,
        'iconColor': primaryGreen,
        'title': 'Orders Successful!',
        'date': '19 Dec, 2022 | 20:49 PM',
        'desc':
            'You have placed an order at Burger Hut and paid \$24. Your food will arrive soon. Enjoy our services 😊',
        'isNew': true,
      },
      {
        'icon': Icons.star,
        'iconColor': Colors.orange,
        'title': 'New Services Available!',
        'date': '14 Dec, 2022 | 10:52 AM',
        'desc':
            'You can now make multiple food orders at one time. You can also cancel your orders.',
        'isNew': false,
      },
      {
        'icon': Icons.credit_card,
        'iconColor': Colors.blue,
        'title': 'Credit Card Connected!',
        'date': '12 Dec, 2022 | 15:38 PM',
        'desc':
            'Your credit card has been successfully linked with Foodu. Enjoy our services.',
        'isNew': false,
      },
      {
        'icon': Icons.person,
        'iconColor': primaryGreen,
        'title': 'Account Setup Successful!',
        'date': '12 Dec, 2022 | 14:27 PM',
        'desc':
            'Your account creation is successful, you can now experience our services.',
        'isNew': false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: item['iconColor'].withOpacity(0.1),
                      child: Icon(item['icon'], color: item['iconColor'], size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (item['isNew'])
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: primaryGreen,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'New',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['date'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item['desc'],
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
