import '/data/models/user.dart';
import '/data/models/address_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

// Successfully loaded user profile
class UserLoaded extends UserState {
  final AppUser user;
  UserLoaded(this.user);
}

// Successfully loaded addresses
class UserAddressLoaded extends UserState {
  final List<AddressModel> addresses;
  UserAddressLoaded(this.addresses);
}

class UserOperationSuccess extends UserState {
  final String message;
  UserOperationSuccess(this.message);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}