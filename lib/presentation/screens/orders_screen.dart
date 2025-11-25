import 'package:flutter/material.dart';

import '../widgets/completed_orders_screen.dart';
import 'active_orders_screen.dart';
import 'cancelled_orders_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const OrdersMainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrdersMainScreen extends StatelessWidget {
  const OrdersMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Active - Completed - Cancelled
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
          centerTitle: false,
          elevation: 5,
          bottom:
          TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey[500],
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),


            unselectedLabelStyle: TextStyle(
              fontSize: 16,        // Unselected tab text size
            ),

            indicatorColor: Colors.green,
            tabs:  [
              Tab(text: "Active"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          )

        ),

        // Pages
        body:TabBarView(
          children: [
            ActiveOrdersScreen(),
            CompletedOrdersScreen(),
            CancelledOrdersScreen(),
          ],
        ),
      ),
    );
  }
}




