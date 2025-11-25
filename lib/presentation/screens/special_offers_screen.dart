// import 'package:cls_tasks/widgets/constants.dart';
// import 'package:cls_tasks/widgets/custom_offer_card.dart';
// import 'package:flutter/material.dart';

// class SpecialOffersScreen extends StatelessWidget {
//   const SpecialOffersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//          leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text(
//           'Special Offers',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body:ListView(
//       padding: const EdgeInsets.all(5.0),
//       children: [
//         CustomOfferCard(
//           bgColor: primaryGreen,
//           offerImage: 'assets/images/special_offer.png',
//           offerpercent: '30%',
//         ),

//         CustomOfferCard(
//           offerImage: 'assets/images/desert.jpeg',
//           offerpercent: '15%',
//           bgColor: Colors.orange,
//         ),

//         CustomOfferCard(
//           offerImage: 'assets/images/pizza.jpeg',
//           offerpercent: '20%',
//           bgColor: Colors.pinkAccent,
//         ),
//          CustomOfferCard(
//           offerImage: 'assets/images/food.jpg',
//           offerpercent: '20%',
//           bgColor: Colors.blue,
//         ),
//       ],
//     ),
//     );


//   }
// }

import 'package:flutter/material.dart';
import '/data/models/offers_item.dart';
import '/data/services/home_services.dart';
import '/presentation/widgets/constants.dart';
import '/presentation/widgets/custom_offer_card.dart';



class SpecialOffersScreen extends StatelessWidget {
  const SpecialOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        title: const Text('Special Offers', style: TextStyle(color: Colors.black)),
      ),
      body: StreamBuilder<List<OffersItem>>(
        stream: HomeServices.getOffers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: primaryGreen,));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final offers = snapshot.data ?? [];

          if (offers.isEmpty) {
            return const Center(child: Text('No active offers right now.',style: TextStyle(color: Colors.black, fontSize: 14),));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              final item = offer.menu_item;

              // You can also skip inactive or expired offers:
              if (!offer.is_active) return const SizedBox.shrink();

              return CustomOfferCard(
                offerImage: item.imageUrl,
                offerpercent: '${offer.discount_percent}%',
                bgColor: primaryGreen,
              );
            },
          );
        },
      ),
    );
  }
}
