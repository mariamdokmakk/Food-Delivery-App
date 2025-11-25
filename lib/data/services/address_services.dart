// import 'package:cloud_firestore/cloud_firestore.dart';
// import '/data/models/address_model.dart';
// import '/data/services/user_services.dart';
//
//
// class AddressService {
//   // Firestore instance
//   static final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   // Collection names
//   static const String _userCollection = "users";
//   static const String _addressCollection = "Addresses";
//
//   /// Save a new address for the current user
//   Future<void> addAddress(AddressModel address) async {
//     final userId = UserServices.getCurrentUser();
//     final docRef = await _db
//         .collection(_userCollection)
//         .doc(userId)
//         .collection(_addressCollection)
//         .add(address.toMap());
//
//     address.id = docRef.id;
//   }
//
//   /// Update an existing address by ID
//   Future<void> updateAddress(AddressModel address) async {
//     final userId = UserServices.getCurrentUser();
//     if (address.id == null) return;
//
//     await _db
//         .collection(_userCollection)
//         .doc(userId)
//         .collection(_addressCollection)
//         .doc(address.id)
//         .update(address.toMap());
//   }
//
//   /// Delete an address by ID
//   Future<void> deleteAddress(String addressId) async {
//     final userId = UserServices.getCurrentUser();
//
//     await _db
//         .collection(_userCollection)
//         .doc(userId)
//         .collection(_addressCollection)
//         .doc(addressId)
//         .delete();
//   }
//
//   /// Get a single address by ID
//   Future<AddressModel?> getAddress(String addressId) async {
//     final userId = UserServices.getCurrentUser();
//
//     final address = await _db
//         .collection(_userCollection)
//         .doc(userId)
//         .collection(_addressCollection)
//         .doc(addressId)
//         .get();
//
//     if (!address.exists) return null;
//
//     return AddressModel.fromMap(address.data()! as String);
//   }
//
//   /// Stream all addresses of the current user
//   Stream<List<AddressModel>> getAllAddresses() {
//     final userId = UserServices.getCurrentUser();
//
//     return _db
//         .collection(_userCollection)
//         .doc(userId)
//         .collection(_addressCollection)
//         .snapshots()
//         .map(
//           (snapshot) => snapshot.docs
//               .map((doc) => AddressModel.fromMap(doc.data()))
//               .toList(),
//         );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import '/data/models/address_model.dart';
import '/data/services/user_services.dart';

class AddressService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const String _userCollection = "users";
  static const String _addressCollection = "addresses";

  /// Add a new address
  Future<void> addAddress(AddressModel address) async {
    final userId = UserServices.getCurrentUser();

    final docRef = await _db
        .collection(_userCollection)
        .doc(userId)
        .collection(_addressCollection)
        .add(address.toMap());

    // Save generated ID into the model
    address.id = docRef.id;
  }

  /// Update address by ID
  Future<void> updateAddress(AddressModel address) async {
    final userId = UserServices.getCurrentUser();
    if (address.id == null) return;

    await _db
        .collection(_userCollection)
        .doc(userId)
        .collection(_addressCollection)
        .doc(address.id)
        .update(address.toMap());
  }

  /// Delete an address
  Future<void> deleteAddress(String addressId) async {
    final userId = UserServices.getCurrentUser();

    await _db
        .collection(_userCollection)
        .doc(userId)
        .collection(_addressCollection)
        .doc(addressId)
        .delete();
  }

  /// Get a single address by ID
  Future<AddressModel?> getAddress(String addressId) async {
    final userId = UserServices.getCurrentUser();

    final doc = await _db
        .collection(_userCollection)
        .doc(userId)
        .collection(_addressCollection)
        .doc(addressId)
        .get();

    if (!doc.exists) return null;

    return AddressModel.fromMap(doc.id, doc.data()!);
  }

  /// Stream all addresses of current user
  Stream<List<AddressModel>> getAllAddresses() {
    final userId = UserServices.getCurrentUser();

    return _db
        .collection(_userCollection)
        .doc(userId)
        .collection(_addressCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AddressModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}
