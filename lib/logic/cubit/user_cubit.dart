import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/services/user_services.dart';
import '/data/services/address_services.dart';
import '/data/models/user.dart';
import '/data/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/logic/cubit/user_state.dart'; // Needed to fetch user manually if service is missing it

class UserCubit extends Cubit<UserState> {
  final AddressService _addressService = AddressService();

  UserCubit() : super(UserInitial());

  // 1. Create or Update User Profile
  Future<void> updateUserProfile(AppUser user) async {
    try {
      emit(UserLoading());
      await UserServices.createUser(user); // Your friend's service function
      emit(UserOperationSuccess("Profile updated successfully!"));
      // After update, reload data
      await getCurrentUserdata();
    } catch (e) {
      emit(UserError("Failed to update profile: $e"));
    }
  }

  // 2. Get Current User Data
  // 2. Get Current User Data
  Future<void> getCurrentUserdata() async {
    try {
      emit(UserLoading());
      final uid = UserServices.getCurrentUser();

      final doc = await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (doc.exists && doc.data() != null) {
        // We have data!
        final user = AppUser.fromMap(doc.data()!);
        emit(UserLoaded(user));
      } else {
        // No data yet (New Guest User)
        // Don't emit Error, emit Loaded with empty/dummy data so UI shows up
        final emptyUser = AppUser(
            id: uid,
            name: "Guest User",
            phone: "",
            email: "No email",
          profileImage: "",
          // latitude: 0.0,
          // longitude: 0.0,
          // gender: "Male",
        );
        emit(UserLoaded(emptyUser));
      }
    } catch (e) {

      emit(UserError("Could not load profile"));
    }
  }

  // 3. Load Addresses
  void loadAddresses() {


    _addressService.getAllAddresses().listen(
          (addresses) {
        emit(UserAddressLoaded(addresses));
      },
      onError: (error) {
        emit(UserError("Failed to load addresses: $error"));
      },
    );
  }


  // 4. Add New Address
  Future<void> addNewAddress(AddressModel address) async {
    try {
      // emit(UserLoading()); // Optional: Keep loading state handled by stream
      await _addressService.addAddress(address);
      // No need to emit success, the stream in loadAddresses will update automatically
    } catch (e) {
      emit(UserError("Failed to add address: $e"));
    }
  }
}