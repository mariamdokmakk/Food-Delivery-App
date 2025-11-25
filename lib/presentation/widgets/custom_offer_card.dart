import 'package:flutter/material.dart';
import '/presentation/widgets/constants.dart';

// ignore: must_be_immutable
class CustomOfferCard extends StatelessWidget {
  CustomOfferCard({
    super.key,
    required this.offerImage,
    required this.offerpercent,
    this.bgColor = primaryGreen,
  });
  String offerImage;
  String offerpercent;
  Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Flexible(
              flex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offerpercent,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Discount Only',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Valid For Today!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  offerImage,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:cls_tasks/widgets/constants.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class CustomOfferCard extends StatelessWidget {
//   CustomOfferCard({
//     super.key,
//     required this.offerImage,
//     required this.offerpercent,
//     this.bgColor = primaryGreen,
//   });

//   final String offerImage;
//   final String offerpercent;
//   final Color bgColor;

//   bool _isNetworkImage(String url) {
//     return url.startsWith('http://') || url.startsWith('https://');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: bgColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Row(
//           children: [
//             Flexible(
//               flex: 0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     offerpercent,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Text(
//                     'Discount Only',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Text(
//                     'Valid For Today!',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               flex: 3,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: _isNetworkImage(offerImage)
//                     ? Image.network(
//                         offerImage,
//                         width: double.infinity,
//                         height: 160,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) => const Icon(
//                           Icons.broken_image,
//                           size: 60,
//                           color: Colors.white,
//                         ),
//                       )
//                     : Image.asset(
//                         offerImage,
//                         width: double.infinity,
//                         height: 160,
//                         fit: BoxFit.cover,
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

