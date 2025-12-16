import 'package:food_delivery_app/data/models/user.dart';
import 'package:food_delivery_app/data/models/address_model.dart';
import 'package:food_delivery_app/data/models/menu_item.dart';

/// Mock data factories for testing
class MockData {
  /// Creates a sample user for testing
  static AppUser sampleUser({
    String? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return AppUser(
      id: id ?? 'test_user_123',
      name: name ?? 'Test User',
      email: email ?? 'test@example.com',
      phone: phone ?? '+1234567890',
      profileImage: 'https://example.com/profile.jpg',
    );
  }

  /// Creates a sample address for testing
  static AddressModel sampleAddress({
    String? id,
    String? label,
    String? description,
  }) {
    return AddressModel(
      id: id ?? 'address_123',
      label: label ?? 'Home',
      description: description ?? '123 Main St, New York, NY',
      latitude: 40.7128,
      longitude: -74.0060,
    );
  }

  /// Creates a list of sample addresses
  static List<AddressModel> sampleAddressList() {
    return [
      sampleAddress(id: '1', label: 'Home', description: '123 Main St'),
      sampleAddress(id: '2', label: 'Work', description: '456 Office Blvd'),
      sampleAddress(id: '3', label: 'Other', description: '789 Park Ave'),
    ];
  }

  /// Creates a sample menu item for testing
  static MenuItem sampleMenuItem({
    String? id,
    String? name,
    String? description,
    num? price,
    String? category,
    String? imageUrl,
  }) {
    return MenuItem(
      id: id ?? 'item_123',
      name: name ?? 'Margherita Pizza',
      description: description ?? 'Classic tomato and mozzarella pizza',
      price: price ?? 12.99,
      category: category ?? 'Pizza',
      imageUrl: imageUrl ?? 'https://example.com/pizza.jpg',
      totalOrderCount: 100, newPrice: 0,
    );
  }

  /// Creates a list of sample menu items
  static List<MenuItem> sampleMenuItemList() {
    return [
      sampleMenuItem(id: '1', name: 'Margherita Pizza', price: 12.99),
      sampleMenuItem(id: '2', name: 'Pepperoni Pizza', price: 14.99),
      sampleMenuItem(id: '3', name: 'Veggie Pizza', price: 13.99),
    ];
  }
}
