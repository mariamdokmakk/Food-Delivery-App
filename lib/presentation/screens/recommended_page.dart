import 'package:flutter/material.dart';
import '../../data/models/menu_item.dart';
import '../../data/services/home_services.dart';
import '../widgets/custom_munue_card.dart';
import 'item_details_screen.dart';


class RecommendedPage extends StatelessWidget {
  const RecommendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),

        // iconTheme:Theme.of(context).iconButtonTheme,
        title:Text(
          'Best Seller 😍',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // body: MenuSection(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            StreamBuilder<List<MenuItem>>(
              stream: HomeServices.getBestSellers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final bestSellers = snapshot.data ?? [];

                if (bestSellers.isEmpty) {
                  return  Center(
                    child: Text(
                      'No best sellers yet!',
                      style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 14),
                    ),
                  );
                }

                return SizedBox(
                  height: 800,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bestSellers.length,
                    itemBuilder: (context, index) {
                      final item = bestSellers[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child:
                        CustomMunueCard(
                          foodImage: item.imageUrl,
                          foodName: item.name,
                          foodDetails: item.description,
                          foodPrice: '\$${item.price.toStringAsFixed(2)}',
                          menuItem: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => itemDetailsScreen(menuItem: item),
                              ),
                            );
                          },
                        )

                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


