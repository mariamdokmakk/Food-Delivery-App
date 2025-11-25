import 'package:flutter/material.dart';
import '/data/models/order.dart';
import '/presentation/widgets/empty_state_widget.dart';
import '/presentation/widgets/order_card.dart';

import '../../../data/services/order_services.dart';

class CancelledOrdersScreen extends StatelessWidget {
  const CancelledOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderItem>>(
      stream: OrderServices.getCancelledOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4CAF50),
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
            subtitle: 'You do not have any cancelled orders',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(
              order: order,
            );
          },
        );
      },
    );
  }
}
