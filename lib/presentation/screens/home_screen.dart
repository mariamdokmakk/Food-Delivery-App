
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/menu_item.dart';
import '../../data/services/cart_services.dart';
import '../../data/services/home_services.dart';
import '../../logic/cubit/user_cubit.dart';
import '../../logic/cubit/user_state.dart';
import '../../presentation/screens/cart_page.dart';
import '../../presentation/screens/catagory_page.dart';

import '../../presentation/screens/notification_page.dart';
import '../../presentation/screens/recommended_page.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/special_offers_screen.dart';
import '../../presentation/widgets/menu_section.dart';
import '../../presentation/widgets/custom_offer_card.dart';
import '../widgets/custom_category.dart';
import '../widgets/custom_food_card.dart';
import 'item_details_screen.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
         backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return  CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (state is UserLoaded) {
                final user = state.user;
                return CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: user.profileImage.isNotEmpty
                      ? NetworkImage(user.profileImage)
                      : null,
                  child: user.profileImage.isEmpty
                      ? const Icon(Icons.person, size: 26, color: Colors.white)
                      : null,
                );
              }
              return CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              );
            },
          ),
        ),



        title:  Text(
          'To The Bone',
          style: TextStyle(
               color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 24),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Notification Icon
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
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

                ],
              ),
              SizedBox(width: 12.w),

              // Cart Icon with dynamic badge
              ValueListenableBuilder<int>(
                valueListenable: CartServices.cartCountNotifier,
                builder: (context, count, _) {
                  return Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        radius: 20.r,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartScreen()),
                            );
                          },
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      if (count > 0)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              count.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(width: 10.w),
            ],
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
                  color: Theme.of(context).iconTheme.color,
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
                  borderSide:  BorderSide(color:Theme.of(context).colorScheme.primary),
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
                  child: Text('See All', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpecialOffersScreen(),
                  ),
                );
              },
              child: CustomOfferCard(
                bgColor: Theme.of(context).colorScheme.primary,
                offerImage: 'assets/images/default.png', // any static banner image
                offerpercent: 'Offers!',
                offerTitle: 'Special Offers',   ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize:MainAxisSize.max,
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
                  child: Text('See All', style: TextStyle(color:Theme.of(context).colorScheme.primary),),
                ),
              ],

            ),
            StreamBuilder<List<MenuItem>>(
              stream: HomeServices.getBestSellers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                    child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final menuItems = snapshot.data ?? [];

                if (menuItems.isEmpty) {
                  return Center(child: Text('No menu items found'));
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
                        child:
                        InkWell(
                          onTap: (){    Navigator.of(context).push(
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
            SizedBox(height: screenHeight * 0.03 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuScreen(),
                      ),
                    );
                  },
                  child: Text('See All', style: TextStyle(color:Theme.of(context).colorScheme.primary),),
                ),

              ],
            ),
            SizedBox(height: screenHeight * 0.01 ,),
            MenuSection()

          ],
        ),
      ),
    );
  }
}
