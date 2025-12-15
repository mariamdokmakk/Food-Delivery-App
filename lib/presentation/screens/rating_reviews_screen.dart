// import 'package:flutter/material.dart';
// import '/presentation/widgets/review_tile.dart';
// class RatingReviewsScreen extends StatefulWidget {
//   const RatingReviewsScreen({super.key});
//
//   @override
//   State<RatingReviewsScreen> createState() => _RatingReviewsScreenState();
// }
//
// class _RatingReviewsScreenState extends State<RatingReviewsScreen> {
//   int _selectedChipIndex = 0; // 0 for "Sort by", 1 for "5", etc.
//   final List<String> _chipLabels = ['Sort by', '5', '4', '3'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rating & Reviews'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 1. Rating Summary Section
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // --- Left Side (Overall Rating) ---
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       children: [
//                         const Text(
//                           '4.8',
//                           style: TextStyle(
//                             fontSize: 48,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.star, color: Colors.amber, size: 18),
//                             Icon(Icons.star, color: Colors.amber, size: 18),
//                             Icon(Icons.star, color: Colors.amber, size: 18),
//                             Icon(Icons.star, color: Colors.amber, size: 18),
//                             Icon(Icons.star_half, color: Colors.amber, size: 18),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           '(4.8k reviews)',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//
//                   // --- Right Side (Rating Bars) ---
//                   Expanded(
//                     flex: 2,
//                     child: Column(
//                       children: [
//                         _buildRatingBar(context, '5', 0.8),
//                         _buildRatingBar(context, '4', 0.5),
//                         _buildRatingBar(context, '3', 0.2),
//                         _buildRatingBar(context, '2', 0.1),
//                         _buildRatingBar(context, '1', 0.05),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               // 2. Filter Chips Section
//               SizedBox(
//                 height: 40,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _chipLabels.length,
//                   itemBuilder: (context, index) {
//                     bool isSelected = _selectedChipIndex == index;
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: ChoiceChip(
//                         label: Text(_chipLabels[index]),
//                         avatar: _chipLabels[index] == 'Sort by'
//                             ? const Icon(Icons.swap_vert, size: 16)
//                             : (_chipLabels[index] != 'Sort by'
//                             ? const Icon(Icons.star, size: 16, color: Colors.amber)
//                             : null),
//                         selected: isSelected,
//                         onSelected: (bool selected) {
//                           setState(() {
//                             _selectedChipIndex = selected ? index : -1;
//                           });
//                         },
//                         selectedColor: Theme.of(context).primaryColor.withOpacity(0.1),
//                         labelStyle: TextStyle(
//                           color: isSelected ? Theme.of(context).primaryColor : Colors.black,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           side: BorderSide(
//                             color: isSelected
//                                 ? Theme.of(context).primaryColor
//                                 : Colors.grey.shade300,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 24),
//               // 3. Reviews List Section
//               const Column(
//                 children: [
//                   ReviewTile(
//                     name: 'Charolette Hanlin',
//                     reviewText: 'Excellent food. Menu is extensive and seasonal to a particularly high standard. Definitely fine dining.',
//                     likes: 938,
//                     date: '6 days ago',
//                     rating: 5.0,
//                   ),
//                   Divider(),
//                   ReviewTile(
//                     name: 'Darron Kulikowski',
//                     reviewText: 'This is my absolute favorite restaurant in. The food is always fantastic and no matter what I order I am always delighted with my meal!',
//                     likes: 863,
//                     date: '2 weeks ago',
//                     rating: 4.0,
//                   ),
//                   Divider(),
//                   ReviewTile(
//                     name: 'Lauralee Quintero',
//                     reviewText: 'Delicious dishes, beautiful presentation. wide wine list and wonderful dessert. I recommend to everyone!',
//                     likes: 629,
//                     date: '2 weeks ago',
//                     rating: 4.0,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Inside the RatingReviewsScreen class, after the build method
//   Widget _buildRatingBar(BuildContext context, String star, double percent) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(star, style: const TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(width: 8),
//           Expanded(
//             child: LinearProgressIndicator(
//               value: percent,
//               backgroundColor: Colors.grey.shade300,
//               color: Theme.of(context).primaryColor,
//               minHeight: 6,
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }