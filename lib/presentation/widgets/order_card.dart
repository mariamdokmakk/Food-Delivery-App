import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/data/models/order.dart';

class OrderCard extends StatelessWidget {
  final OrderItem order;
  final VoidCallback? onTrackDriver;
  final VoidCallback? onCancelOrder;
  final VoidCallback? onLeaveReview;
  final VoidCallback? onOrderAgain;

  const OrderCard({
    super.key,
    required this.order,
    this.onTrackDriver,
    this.onCancelOrder,
    this.onLeaveReview,
    this.onOrderAgain,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive =
        order.orderState == 'pending' ||
        order.orderState == 'preparing' ||
        order.orderState == 'onTheWay';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =================== ITEMS WITH QUANTITY ===================
          ...order.items.map((item) {
            final name = item['name'];
            final quantity =
                item['quantity']; // get quantity directly from the map
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    "$name",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "x$quantity",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          const SizedBox(height: 12),

          // =================== TOTAL PRICE ===================
          Text(
            "Total: \$${order.totalPrice.toStringAsFixed(2)}",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 12),

          // =================== STATUS TAG ===================
          _buildStatusTag(context),

          const SizedBox(height: 12),

          // =================== ACTION BUTTONS ===================
          _buildActionButtons(isActive, context),
        ],
      ),
    );
  }

  // =================== ORDER STATUS TAG ===================
  Widget _buildStatusTag(BuildContext context) {
    final statusConfig = {
      'pending': {'color': Colors.orange, 'text': 'Pending'},
      'preparing': {'color': Colors.blue, 'text': 'Preparing'},
      'onTheWay': {'color': Colors.purple, 'text': 'On the Way'},
      'completed': {'color': Colors.green, 'text': 'Completed'},
      'canceled': {'color': Colors.red, 'text': 'Canceled'},
    };

    final config = statusConfig[order.orderState]!;
    final color = config['color'] as Color;
    final text = config['text'] as String;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // =================== BUTTONS ===================
  Widget _buildActionButtons(bool isActive, BuildContext context) {
    final buttons = isActive
        ? [
            {
              'text': 'Cancel Order',
              'callback': onCancelOrder,
              'isPrimary': false,
            },
            {
              'text': 'Track Driver',
              'callback': onTrackDriver,
              'isPrimary': true,
            },
          ]
        : [
            {
              'text': 'Leave a Review',
              'callback': onLeaveReview,
              'isPrimary': false,
            },
            {
              'text': 'Order Again',
              'callback': onOrderAgain,
              'isPrimary': true,
            },
          ];

    return Row(
      children: [
        for (int i = 0; i < buttons.length; i++) ...[
          Expanded(child: _buildButton(buttons[i], context)),
          if (i < buttons.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }

  Widget _buildButton(Map<String, dynamic> config, BuildContext context) {
    final isPrimary = config['isPrimary'] as bool;
    final text = config['text'] as String;
    final callback = config['callback'] as VoidCallback?;

    return isPrimary
        ? ElevatedButton(
            onPressed: callback,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 1),
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : OutlinedButton(
            onPressed: callback,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 1),
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
  }
}
