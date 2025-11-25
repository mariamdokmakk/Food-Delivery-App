
import 'package:flutter/material.dart';
import '/presentation/widgets/best_seller_section.dart';

class RecommendedPage extends StatelessWidget {
  const RecommendedPage({super.key});

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
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Best Seller 😍',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BestSellersSection(),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: ListView(
      //     children: [
      //       SingleChildScrollView(
      //         scrollDirection: Axis.horizontal,
      //         child: Row(
      //           children: [
      //             CustomerContainer(
      //               categoryImage: 'assets/images/icons8-checked.png',
      //               categoryName: 'All',
      //             ),
      //             const SizedBox(width: 24),
      //             CustomerContainer(
      //               categoryImage: 'assets/images/burger_icon.png',
      //               categoryName: 'Burger',
      //             ),
      //             const SizedBox(width: 24),
      //             CustomerContainer(
      //               categoryImage: 'assets/images/pizza-icon.png',
      //               categoryName: 'Pizza',
      //             ),
      //             const SizedBox(width: 24),
      //             CustomerContainer(
      //               categoryImage: 'assets/images/drink_icon.png',
      //               categoryName: 'Drink',
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       StreamBuilder<List<MenuItem>>(
      //         stream: HomeServices.getBestSellers(),
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return const Center(
      //               child: CircularProgressIndicator(color: primaryGreen),
      //             );
      //           }

      //           if (snapshot.hasError) {
      //             return Center(child: Text('Error: ${snapshot.error}'));
      //           }

      //           final bestSellers = snapshot.data ?? [];

      //           if (bestSellers.isEmpty) {
      //             return const Center(
      //               child: Text(
      //                 'No best sellers yet!',
      //                 style: TextStyle(color: Colors.black54, fontSize: 14),
      //               ),
      //             );
      //           }

      //           return SizedBox(
      //             height: 800,
      //             child: ListView.builder(
      //               shrinkWrap: true,
      //               physics: const NeverScrollableScrollPhysics(),
      //               itemCount: bestSellers.length,
      //               itemBuilder: (context, index) {
      //                 final item = bestSellers[index];
      //                 return Padding(
      //                   padding: const EdgeInsets.only(bottom: 10),
      //                   child: CustomMunueCard(
      //                     foodImage: item.image_url,
      //                     foodName: item.name,
      //                     foodDetails: item.description,
      //                     foodPrice: '\$${item.price.toStringAsFixed(2)}',
      //                     menuItem: item,
      //                   ),
      //                 );
      //               },
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
