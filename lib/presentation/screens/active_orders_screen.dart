import 'package:flutter/material.dart';
import '/data/models/order.dart';
import '/presentation/screens/cancel_order_screen.dart';
import '/presentation/widgets/empty_state_widget.dart';
import '/presentation/widgets/order_card.dart';
import '../../../data/services/order_services.dart';


class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<List<OrderItem>>(
      stream: OrderServices.getActiveOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final orders = snapshot.data ?? [];

        if (orders.isEmpty) {
          return const EmptyStateWidget(
            title: 'Empty',
            subtitle: 'You do not have an active order at this time',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(
              order: order,
              onTrackDriver: () {
                // Navigate to tracking screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tracking feature coming soon!'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              },
              onCancelOrder: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CancelOrderScreen(order: order),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
