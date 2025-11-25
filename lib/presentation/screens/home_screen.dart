// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: FutureBuilder<String?>(
//             future: UserServices.getUserName(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircleAvatar(
//                   backgroundColor: primaryGreen,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                     strokeWidth: 2,
//                   ),
//                 );
//               }

//               final name = snapshot.data ?? '';
//               final firstChar = name.isNotEmpty ? name[0].toUpperCase() : '?';

//               return CircleAvatar(
//                 backgroundColor: primaryGreen,
//                 child: Text(
//                   firstChar,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),

//         title: const Text(
//           'Deliver to',
//           style: TextStyle(color: Colors.grey, fontSize: 24),
//         ),
//         actions: [
//           Stack(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 20,
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const NotificationPage(),
//                       ),
//                     );
//                   },
//                   icon: const Icon(
//                     Icons.notifications_none_outlined,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 4,
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(width: 16),
//           Stack(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 20,
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const CardPage()),
//                     );
//                   },
//                   icon: const Icon(
//                     Icons.shopping_bag_outlined,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 4,
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(9),
//         child: ListView(
//           children: [
//             TextField(
//               cursorColor: Colors.grey,
//               //onChanged: onSearchTextChange,
//               decoration: InputDecoration(
//                 prefixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   color: Colors.grey,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SearchScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 hintText: 'What are you craving?',
//                 filled: true,
//                 fillColor: Colors.grey.shade200,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: const BorderSide(color: primaryGreen),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Text(
//                   'Special Offers',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(width: 180),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SpecialOffersScreen(),
//                       ),
//                     );
//                   },
//                   child: Text('See All', style: TextStyle(color: primaryGreen)),
//                 ),
//               ],
//             ),
//             CustomOfferCard(
//               bgColor: primaryGreen,
//               offerImage: 'assets/images/special_offer.png',
//               offerpercent: '30%',
//             ),
//             const SizedBox(height: 20),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   CustomCategory(
//                     categoryImage: 'assets/images/burger_icon.png',
//                     categoryName: 'Burger',
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               const CategoryPage(categoryName: 'Burger'),
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(width: 50),
//                   CustomCategory(
//                     categoryImage: 'assets/images/pizza-icon.png',
//                     categoryName: 'Pizza',
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               const CategoryPage(categoryName: 'Pizza'),
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(width: 50),
//                   CustomCategory(
//                     categoryImage: 'assets/images/desser_icon.png',
//                     categoryName: 'Dessert',
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               const CategoryPage(categoryName: 'Dessert'),
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(width: 50),
//                   CustomCategory(
//                     categoryImage: 'assets/images/drink_icon.png',
//                     categoryName: 'Drink',
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               const CategoryPage(categoryName: 'Drink'),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),

//             // SizedBox(
//             //   height: 280, // set an appropriate height for your food cards
//             //   child: ListView.builder(
//             //     scrollDirection: Axis.horizontal,
//             //     itemCount: 6,
//             //     itemBuilder: (context, index) {
//             //       return CustomFoodCard();
//             //     },
//             //   ),
//             // ),
//             SingleChildScrollView(
//               //scrollDirection: Axis.horizontal,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   StreamBuilder<List<MenuItem>>(
//                     stream: HomeServices.getMenuItems(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(
//                           child: CircularProgressIndicator(color: primaryGreen),
//                         );
//                       }

//                       if (snapshot.hasError) {
//                         return Center(child: Text('Error: ${snapshot.error}'));
//                       }

//                       final menuItems = snapshot.data ?? [];

//                       if (menuItems.isEmpty) {
//                         return const Center(child: Text('No menu items found'));
//                       }

//                       return SizedBox(
//                         height: 280,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: menuItems.length,
//                           itemBuilder: (context, index) {
//                             final item = menuItems[index];
//                             return Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: CustomFoodCard(item: item),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             Row(
//               children: [
//                 Text(
//                   'Best Seller 😍',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(width: 190),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const RecommendedPage(),
//                       ),
//                     );
//                   },
//                   child: Text('See All', style: TextStyle(color: primaryGreen)),
//                 ),
//               ],
//             ),
//             // SingleChildScrollView(
//             //   scrollDirection: Axis.horizontal,
//             //   child: Row(
//             //     children: [
//             //       CustomerContainer(
//             //         categoryImage: 'assets/images/icons8-checked.png',
//             //         categoryName: 'All',
//             //       ),
//             //       const SizedBox(width: 24),
//             //       CustomerContainer(
//             //         categoryImage: 'assets/images/burger_icon.png',
//             //         categoryName: 'Burger',
//             //       ),
//             //       const SizedBox(width: 24),
//             //       CustomerContainer(
//             //         categoryImage: 'assets/images/pizza-icon.png',
//             //         categoryName: 'Pizza',
//             //       ),
//             //       const SizedBox(width: 24),
//             //       CustomerContainer(
//             //         categoryImage: 'assets/images/drink_icon.png',
//             //         categoryName: 'Drink',
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             SizedBox(height: 30),
//             const BestSellersSection(),

//             // StreamBuilder<List<MenuItem>>(
//             //   stream: HomeServices.getBestSellers(),
//             //   builder: (context, snapshot) {
//             //     if (snapshot.connectionState == ConnectionState.waiting) {
//             //       return const Center(
//             //         child: CircularProgressIndicator(color: primaryGreen),
//             //       );
//             //     }

//             //     if (snapshot.hasError) {
//             //       return Center(child: Text('Error: ${snapshot.error}'));
//             //     }

//             //     final bestSellers = snapshot.data ?? [];

//             //     if (bestSellers.isEmpty) {
//             //       return const Center(
//             //         child: Text(
//             //           'No best sellers yet!',
//             //           style: TextStyle(color: Colors.black54, fontSize: 14),
//             //         ),
//             //       );
//             //     }

//             //     return SizedBox(
//             //       height: 800,
//             //       child: ListView.builder(
//             //         shrinkWrap: true,
//             //         physics: const NeverScrollableScrollPhysics(),
//             //         itemCount: bestSellers.length,
//             //         itemBuilder: (context, index) {
//             //           final item = bestSellers[index];
//             //           return Padding(
//             //             padding: const EdgeInsets.only(bottom: 10),
//             //             child: CustomMunueCard(
//             //               foodImage: item.image_url,
//             //               foodName: item.name,
//             //               foodDetails: item.description,
//             //               foodPrice: '\$${item.price.toStringAsFixed(2)}',
//             //               menuItem: item,
//             //             ),
//             //           );
//             //         },
//             //       ),
//             //     );
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/menu_item.dart';
import '../../data/services/home_services.dart';
import '../../logic/cubit/user_cubit.dart';
import '../../logic/cubit/user_state.dart';
import '../../presentation/screens/cart_page.dart';
import '../../presentation/screens/catagory_page.dart';

import '../../presentation/screens/notification_page.dart';
import '../../presentation/screens/recommended_page.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/special_offers_screen.dart';
import '../../presentation/widgets/best_seller_section.dart';
import '../../presentation/widgets/constants.dart';
import '../../presentation/widgets/custom_offer_card.dart';
import '../widgets/custom_category.dart';
import '../widgets/custom_food_card.dart';
import 'item_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
         backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const CircleAvatar(
                  backgroundColor: primaryGreen,
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (state is UserLoaded) {
                final user = state.user;

                return CircleAvatar(
                  backgroundImage: user.profileImage.isNotEmpty
                      ? NetworkImage(user.profileImage)
                      : const AssetImage("assets/images/avatar.png")
                  as ImageProvider,
                );
              }

              return const CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png"),
              );
            },
          ),
        ),



        title: const Text(
          'Deliver to',
          style: TextStyle(
              // color: Colors.grey,
              fontSize: 24),
        ),
        actions: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor:Theme.of(context).colorScheme.surface,
                radius: 20.r,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              Positioned(
                top: 4.h,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(width: 15.w),
          Padding(
            padding: EdgeInsetsGeometry.all(10.w),
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor:Theme.of(context).colorScheme.surface,
                  radius: 20.r,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                       color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                Positioned(
                  top: 4.h,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(9.w), 
        child: ListView(
          children: <Widget>[
            TextField(
              // cursorColor: Colors.grey,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  // color: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                ),
                hintText: 'What are you craving?',
                filled: true,
                // fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r), 
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r), 
                  borderSide: const BorderSide(color: primaryGreen),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), 
            Row(
              children: [
                Text(
                  'Special Offers',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ), 
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialOffersScreen(),
                      ),
                    );
                  },
                  child: Text('See All', style: TextStyle(color: primaryGreen)),
                ),
              ],
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpecialOffersScreen(),
                  ),
                );
              },
              child: CustomOfferCard(
                bgColor: primaryGreen,
                offerImage: 'assets/images/special_offer.png',
                offerpercent: '30%',
              ),
            ),
            SizedBox(height: screenHeight * 0.02), 
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  CustomCategory(
                    categoryImage: 'assets/images/burger_icon.png',
                    categoryName: 'Burger',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CategoryPage(categoryName: 'Burger'),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: screenWidth * 0.12,
                  ), 
                  CustomCategory(
                    categoryImage: 'assets/images/pizza-icon.png',
                    categoryName: 'Pizza',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CategoryPage(categoryName: 'Pizza'),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: screenWidth * 0.12,
                  ), 
                  CustomCategory(
                    categoryImage: 'assets/images/desser_icon.png',
                    categoryName: 'Dessert',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryPage(categoryName: 'Dessert'),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: screenWidth * 0.12,
                  ), 
                  CustomCategory(
                    categoryImage: 'assets/images/drink_icon.png',
                    categoryName: 'Drink',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryPage(categoryName: 'Drink'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('For you',style: TextStyle(fontSize: 18.sp,
                  fontWeight: FontWeight.bold,),),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecommendedPage(),
                      ),
                    );
                  },
                  child: Text('See All', style: TextStyle(color: primaryGreen),),
                ),
              ],
            ),
            StreamBuilder<List<MenuItem>>(
              stream: HomeServices.getBestSellers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryGreen),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final menuItems = snapshot.data ?? [];

                if (menuItems.isEmpty) {
                  return const Center(child: Text('No menu items found'));
                }

                return SizedBox(
                  height: 280.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                        ),
                        child: InkWell(
                          onTap: (){       Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return itemDetailsScreen(menuItem: item,);
                              },
                            ),
                          );}
                            ,child: CustomFoodCard(item: item)),
                      );
                    },
                  ),
                );
              },
            ),
            Row(
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            BestSellersSection()

          ],
        ),
      ),
    );
  }
}
