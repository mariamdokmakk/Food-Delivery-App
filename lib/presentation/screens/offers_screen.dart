import 'package:flutter/material.dart';
import '/presentation/widgets/promo_card.dart';
class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers Are Available'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Replaced the Column with a ListView
              ListView.builder(
                shrinkWrap: true, // Allows ListView inside SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Lets the parent scroll
                itemCount: 5, // We'll show 5 placeholder cards
                itemBuilder: (context, index) {
                  // Example of showing one as "claimed"
                  bool isClaimed = index == 1;

                  return const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: PromoCard(
                      title: 'Promo New User',
                      description: 'Valid for new users',
                      icon: Icons.person,
                      // isClaimed: isClaimed, // You can uncomment this to test
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}