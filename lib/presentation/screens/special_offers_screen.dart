import 'package:flutter/material.dart';
import '../../data/models/offers_item.dart';
import '../../data/services/home_services.dart';
import '../widgets/custom_offer_card.dart';

class SpecialOffersScreen extends StatelessWidget {
  SpecialOffersScreen({super.key});

  // Map categories to images
  Map<String, String> categoryImages = {
    'pizza': 'assets/images/PIzza.png',
    'drinks': 'assets/images/Drinks.png',
    'burger': 'assets/images/Burger.png',
    'desert':'assets/images/Desert.png'

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).textTheme.bodyMedium!.color),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        title:  Text('Special Offers',style: TextStyle(color: Theme.of(context).iconTheme.color)),
      ),
      body: StreamBuilder<List<OffersItem?>>(
        stream: HomeServices.getOffers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final offers = snapshot.data ?? [];

          if (offers.isEmpty) {
            return const Center(
              child: Text(
                'No active offers right now.',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];

              if (offer == null || !offer.isActive) return const SizedBox.shrink();

              // Pick image based on category, fallback to default
              final image = categoryImages[offer.category.toLowerCase()] ??
                  'assets/images/default.png';

              return CustomOfferCard(
                offerImage: image,
                offerpercent: '${offer.discountPercent}%',
                bgColor: Theme.of(context).colorScheme.primary,
                offerTitle: offer.title,
              );
            },
          );
        },
      ),
    );
  }
}

