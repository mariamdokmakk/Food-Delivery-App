import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/offers_item.dart';

class OfferService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // all active offers from firestore
  static Future<List<OffersItem>> getAllActiveOffers() async {
    try {
      final now = DateTime.now();

      final querySnapshot = await _firestore
          .collection('offers')
          .where('isActive', isEqualTo: true)
          .where('validFrom', isLessThanOrEqualTo: now)
          .where('validTo', isGreaterThanOrEqualTo: now)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return OffersItem.fromMap(data);
      }).toList();
    } catch (e, _) {
      return []; // return empty list on error
    }
  }

  // latest offer
  // static Future<OffersItem?> getLatestOffer() async {
  //   try {
  //     final now = DateTime.now();
  //
  //     final snapshot = await _firestore
  //         .collection('offers')
  //         .where('isActive', isEqualTo: true)
  //         .where('validFrom', isLessThanOrEqualTo: now)
  //         .where('validTo', isGreaterThanOrEqualTo: now)
  //         .orderBy('validFrom', descending: true)
  //         .limit(1)
  //         .get();
  //
  //     if (snapshot.docs.isEmpty) return null;
  //
  //     final data = snapshot.docs.first.data();
  //     data['id'] = snapshot.docs.first.id;
  //     return OffersItem.fromMap(data);
  //   } catch (e) {
  //     return null;
  //   }
  // }

}
