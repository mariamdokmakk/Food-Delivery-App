// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import '/data/models/order.dart';
// //
// // import '../../../../data/services/order_services.dart';
// //
// // class OrderCard extends StatelessWidget {
// //   final OrderItem order;
// //   final VoidCallback? onTrackDriver;
// //   final VoidCallback? onCancelOrder;
// //   final VoidCallback? onLeaveReview;
// //   final VoidCallback? onOrderAgain;
// //
// //   const OrderCard({
// //     super.key,
// //     required this.order,
// //     this.onTrackDriver,
// //     this.onCancelOrder,
// //     this.onLeaveReview,
// //     this.onOrderAgain,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final bool showActionButtons = order.orderState == OrderState.active.name ||
// //         order.orderState == OrderState.completed.name;
// //
// //     return Container(
// //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 12,
// //             spreadRadius: 2,
// //             offset: Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Container(
// //                 width: 100,
// //                 height: 100,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(12),
// //                   image: order.items.isNotEmpty
// //                       ? DecorationImage(
// //                           image: NetworkImage(order.items.first.imageUrl),
// //                           fit: BoxFit.cover,
// //                         )
// //                       : null,
// //                 ),
// //                 child: order.items.isEmpty
// //                     ? const Icon(
// //                         Icons.restaurant,
// //                         color: Colors.white70,
// //                         size: 40,
// //                       )
// //                     : null,
// //               ),
// //               const SizedBox(width: 16),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       order.orderState == OrderState.completed.name ? 'Zero Zero Noodles' : 'Restaurant Name',
// //                       style: GoogleFonts.poppins(
// //                         color: Colors.white,
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Text(
// //                       '${order.items.length} items | ${_getDistance()} km',
// //                       style: GoogleFonts.poppins(
// //                         color:  Colors.white,
// //                         fontSize: 14,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           '\$${order.totalPrice.toStringAsFixed(2)}',
// //                           style: GoogleFonts.poppins(
// //                             color: const Color(0xFF4CAF50),
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 8),
// //                         _buildStatusTag(),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //
// //           if (showActionButtons) ...[
// //             const Padding(
// //               padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
// //               child: Divider(
// //                 color: Color(0xFF424242),
// //                 thickness: 1,
// //                 height: 0,
// //               ),
// //             ),
// //             _buildActionButtons(),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildStatusTag() {
// //     final statusConfig = {
// //       OrderState.active.name: {'color': const Color(0xFF4CAF50), 'text': 'Active'},
// //       OrderState.completed.name: {'color': const Color(0xFF4CAF50), 'text': 'Completed'},
// //       OrderState.cancelled.name: {'color': Colors.red, 'text': 'Cancelled'},
// //     };
// //
// //     final config = statusConfig[order.orderState] ;
// //     final color = config!['color'] as Color;
// //     final text = config['text'] as String;
// //
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: color,
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Text(
// //         text,
// //         style: GoogleFonts.poppins(
// //           color: Colors.white,
// //           fontSize: 12,
// //           fontWeight: FontWeight.w500,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildActionButtons() {
// //     final buttons = {
// //       OrderState.active.name: [
// //         {'text': 'Cancel Order', 'callback': onCancelOrder, 'isPrimary': false},
// //         {'text': 'Track Driver', 'callback': onTrackDriver, 'isPrimary': true},
// //       ],
// //       OrderState.completed.name: [
// //         {'text': 'Leave a Review', 'callback': onLeaveReview, 'isPrimary': false},
// //         {'text': 'Order Again', 'callback': onOrderAgain, 'isPrimary': true},
// //       ],
// //     };
// //
// //     final buttonConfigs = buttons[order.orderState] ?? [];
// //
// //     return Row(
// //       children: [
// //         for (int i = 0; i < buttonConfigs.length; i++) ...[
// //           Expanded(
// //             child: _buildButton(buttonConfigs[i]),
// //           ),
// //           if (i < buttonConfigs.length - 1) const SizedBox(width: 12),
// //         ],
// //       ],
// //     );
// //   }
// //
// //   Widget _buildButton(Map<String, dynamic> config) {
// //     final isPrimary = config['isPrimary'] as bool;
// //     final text = config['text'] as String;
// //     final callback = config['callback'] as VoidCallback?;
// //
// //     return isPrimary
// //         ? ElevatedButton(
// //             onPressed: callback,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color(0xFF4CAF50),
// //               elevation: 0,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(100),
// //               ),
// //               padding: const EdgeInsets.symmetric(vertical: 1),
// //             ),
// //             child: Text(
// //               text,
// //               style: GoogleFonts.poppins(
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           )
// //         : OutlinedButton(
// //             onPressed: callback,
// //             style: OutlinedButton.styleFrom(
// //               side: const BorderSide(color: Color(0xFF4CAF50), width: 1.5),
// //               backgroundColor: const Color(0xFF2E2E2E),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(100),
// //               ),
// //               padding: const EdgeInsets.symmetric(vertical: 1),
// //             ),
// //             child: Text(
// //               text,
// //               style: GoogleFonts.poppins(
// //                 color: const Color(0xFF4CAF50),
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           );
// //   }
// //
// //
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '/data/models/order.dart';
//
// class OrderCard extends StatelessWidget {
//   final OrderItem order;
//   final VoidCallback? onCancelOrder;
//   final VoidCallback? onLeaveReview;
//   final VoidCallback? onOrderAgain;
//
//   const OrderCard({
//     super.key,
//     required this.order,
//     this.onCancelOrder,
//     this.onLeaveReview,
//     this.onOrderAgain,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isActive = order.orderState == 'pending' ||
//         order.orderState == 'preparing' ||
//         order.orderState == 'onTheWay';
//
//     final bool showActionButtons = isActive || order.orderState == 'completed';
//
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 12,
//             spreadRadius: 2,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: order.items.isNotEmpty
//                       ? DecorationImage(
//                     image: NetworkImage(order.items.first.imageUrl),
//                     fit: BoxFit.cover,
//                   )
//                       : null,
//                 ),
//                 child: order.items.isEmpty
//                     ? const Icon(
//                   Icons.restaurant,
//                   color: Colors.white70,
//                   size: 40,
//                 )
//                     : null,
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       order.orderState == 'completed'
//                           ? 'Zero Zero Noodles'
//                           : 'Restaurant Name',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '${order.items.length} items',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Text(
//                           '\$${order.totalPrice.toStringAsFixed(2)}',
//                           style: GoogleFonts.poppins(
//                             color: const Color(0xFF4CAF50),
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         _buildStatusTag(),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           if (showActionButtons) ...[
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Divider(
//                 color: Color(0xFF424242),
//                 thickness: 1,
//                 height: 0,
//               ),
//             ),
//             _buildActionButtons(isActive),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatusTag() {
//     final statusConfig = {
//       'pending': {'color': Colors.orange, 'text': 'Pending'},
//       'preparing': {'color': Colors.blue, 'text': 'Preparing'},
//       'onTheWay': {'color': Colors.purple, 'text': 'On the Way'},
//       'completed': {'color': Colors.green, 'text': 'Completed'},
//       'cancelled': {'color': Colors.red, 'text': 'Cancelled'},
//     };
//
//     final config = statusConfig[order.orderState]!;
//     final color = config['color'] as Color;
//     final text = config['text'] as String;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(
//           color: Colors.white,
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButtons(bool isActive) {
//     final buttons = isActive
//         ? [
//       {'text': 'Cancel Order', 'callback': onCancelOrder, 'isPrimary': false},
//     ]
//         : [
//       {'text': 'Leave a Review', 'callback': onLeaveReview, 'isPrimary': false},
//       {'text': 'Order Again', 'callback': onOrderAgain, 'isPrimary': true},
//     ];
//
//     return Row(
//       children: [
//         for (int i = 0; i < buttons.length; i++) ...[
//           Expanded(child: _buildButton(buttons[i])),
//           if (i < buttons.length - 1) const SizedBox(width: 12),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildButton(Map<String, dynamic> config) {
//     final isPrimary = config['isPrimary'] as bool;
//     final text = config['text'] as String;
//     final callback = config['callback'] as VoidCallback?;
//
//     return isPrimary
//         ? ElevatedButton(
//       onPressed: callback,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF4CAF50),
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(100),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 1),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     )
//         : OutlinedButton(
//       onPressed: callback,
//       style: OutlinedButton.styleFrom(
//         side: const BorderSide(color: Color(0xFF4CAF50), width: 1.5),
//         backgroundColor: const Color(0xFF2E2E2E),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(100),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 1),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(
//           color: const Color(0xFF4CAF50),
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/data/models/order.dart';

import '../../../../data/services/order_services.dart';

// class OrderCard extends StatelessWidget {
//   final OrderItem order;
//   final VoidCallback? onTrackDriver;
//   final VoidCallback? onCancelOrder;
//   final VoidCallback? onLeaveReview;
//   final VoidCallback? onOrderAgain;
//
//   const OrderCard({
//     super.key,
//     required this.order,
//     this.onTrackDriver,
//     this.onCancelOrder,
//     this.onLeaveReview,
//     this.onOrderAgain,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isActive = order.orderState == 'pending' ||
//         order.orderState == 'preparing' ||
//         order.orderState == 'onTheWay';
//
//     final bool showActionButtons = isActive || order.orderState == 'completed';
//
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 12,
//             spreadRadius: 2,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: order.items.isNotEmpty
//                       ? DecorationImage(
//                     image: NetworkImage(order.items.first.imageUrl),
//                     fit: BoxFit.cover,
//                   )
//                       : null,
//                 ),
//                 child: order.items.isEmpty
//                     ? Icon(
//                   Icons.restaurant,
//                   color: Theme.of(context).iconTheme.color,
//                   size: 40,
//                 )
//                     : null,
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       order.orderState == 'completed'
//                           ? 'Zero Zero Noodles'
//                           : 'Restaurant Name',
//                       style: GoogleFonts.poppins(
//                         color: Theme.of(context).textTheme.bodyMedium!.color,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '${order.items.length} items | ${_getDistance()} km',
//                       style: GoogleFonts.poppins(
//                         color: Theme.of(context).textTheme.bodyMedium!.color,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           '\$${order.totalPrice.toStringAsFixed(2)}',
//                           style: GoogleFonts.poppins(
//                             color: Theme.of(context).colorScheme.primary,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         _buildStatusTag(),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           if (showActionButtons) ...[
//             const Padding(
//               padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
//               child: Divider(
//                 color: Color(0xFF424242),
//                 thickness: 1,
//                 height: 0,
//               ),
//             ),
//             _buildActionButtons(isActive),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatusTag(context) {
//     final statusConfig = {
//       'pending': {'color': Colors.orange, 'text': 'Pending'},
//       'preparing': {'color': Colors.blue, 'text': 'Preparing'},
//       'onTheWay': {'color': Colors.purple, 'text': 'On the Way'},
//       'completed': {'color': Colors.green, 'text': 'Completed'},
//       'cancelled': {'color': Colors.red, 'text': 'Cancelled'},
//     };
//
//     final config = statusConfig[order.orderState]!;
//     final color = config['color'] as Color;
//     final text = config['text'] as String;
//
//     return Container(
//       padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(
//           color: Theme.of(context).textTheme.bodyMedium!.color,
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButtons(bool isActive,context) {
//     final buttons = isActive
//         ? [
//       {'text': 'Cancel Order', 'callback': onCancelOrder, 'isPrimary': false},
//       {'text': 'Track Driver', 'callback': onTrackDriver, 'isPrimary': true},
//     ]
//         : [
//       {'text': 'Leave a Review', 'callback': onLeaveReview, 'isPrimary': false},
//       {'text': 'Order Again', 'callback': onOrderAgain, 'isPrimary': true},
//     ];
//
//     return Row(
//       children: [
//         for (int i = 0; i < buttons.length; i++) ...[
//           Expanded(child: _buildButton(buttons[i])),
//           if (i < buttons.length - 1) const SizedBox(width: 12),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildButton(Map<String, dynamic> config) {
//     final isPrimary = config['isPrimary'] as bool;
//     final text = config['text'] as String;
//     final callback = config['callback'] as VoidCallback?;
//
//     return isPrimary
//         ? ElevatedButton(
//       onPressed: callback,
//       style: ElevatedButton.styleFrom(
//         backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(100),
//         ),
//         padding:  EdgeInsets.symmetric(vertical: 1),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(
//           color: Theme.of(context).textTheme.bodyMedium!.color,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     )
//         : OutlinedButton(
//       onPressed: callback,
//       style: OutlinedButton.styleFrom(
//         side: BorderSide(color:Theme.of(context).colorScheme.primary, width: 1.5),
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(100),
//         ),
//         padding:  EdgeInsets.symmetric(vertical: 1),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(
//           color: Theme.of(context).colorScheme.primary,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//
//   String _getDistance() {
//     if (order.orderState == 'completed') {
//       return '2.7';
//     }
//     return (1.0 + (order.id.hashCode % 50) / 10).toStringAsFixed(1);
//   }
// }

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

    final bool showActionButtons = isActive || order.orderState == 'completed';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // 🔥 dynamic card color
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- IMAGE ---
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: order.items.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(order.items.first.imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: order.items.isEmpty
                    ? Icon(
                        Icons.restaurant,
                        color: Theme.of(context).iconTheme.color,
                        size: 40,
                      )
                    : null,
              ),

              const SizedBox(width: 16),

              // --- TEXT SECTION ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderState == 'completed'
                          ? 'Zero Zero Noodles'
                          : 'Restaurant Name',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${order.items.length} items | ${_getDistance()} km',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text(
                          '\$${order.totalPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildStatusTag(context), // 🔥 FIXED
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (showActionButtons) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: Color(0xFF424242), thickness: 1),
            ),

            _buildActionButtons(isActive, context), // 🔥 FIXED
          ],
        ],
      ),
    );
  }

  // -------------------- STATUS TAG --------------------
  Widget _buildStatusTag(BuildContext context) {
    final statusConfig = {
      'pending': {'color': Colors.orange, 'text': 'Pending'},
      'preparing': {'color': Colors.blue, 'text': 'Preparing'},
      'onTheWay': {'color': Colors.purple, 'text': 'On the Way'},
      'completed': {'color': Colors.green, 'text': 'Completed'},
      'cancelled': {'color': Colors.red, 'text': 'Cancelled'},
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

  // -------------------- BUTTONS --------------------
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
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          )
        : OutlinedButton(
            onPressed: callback,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
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

  String _getDistance() {
    if (order.orderState == 'completed') {
      return '2.7';
    }
    return (1.0 + (order.id.hashCode % 50) / 10).toStringAsFixed(1);
  }
}
