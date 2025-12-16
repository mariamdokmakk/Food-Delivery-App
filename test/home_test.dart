import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test services/home_services_test.dart';

void main() {
  late FakeFirebaseFirestore fakeDb;
  late HomeServicesTest homeServices;

  setUp(() async {
    fakeDb = FakeFirebaseFirestore();
    homeServices = HomeServicesTest(db: fakeDb);

    await fakeDb.collection("Offers").add({
      "title": "Discount 20%",
      "image": "offer.png",
    });

    await fakeDb
        .collection("Restaurant")
        .doc("UFrCk69XBDrXFMOCuMvB")
        .collection("menu")
        .add({
      "name": "Burger",
      "category": "Fast Food",
      "price": 50,
      "totalOrderCount": 30,
    });

    await fakeDb
        .collection("Restaurant")
        .doc("UFrCk69XBDrXFMOCuMvB")
        .collection("menu")
        .add({
      "name": "Pizza",
      "category": "Fast Food",
      "price": 80,
      "totalOrderCount": 50,
    });

    await fakeDb
        .collection("Restaurant")
        .doc("UFrCk69XBDrXFMOCuMvB")
        .collection("menu")
        .add({
      "name": "Salad",
      "category": "Healthy",
      "price": 40,
      "totalOrderCount": 10,
    });
  });

 test("getOffers() returns list of offers", () async {
  final fakeDb = FakeFirebaseFirestore();
  final homeServices = HomeServicesTest(db: fakeDb);

  await fakeDb.collection("Offers").add({
    "id": "offer1",
    "discount_percent": 20,
    "is_active": true,
    "valid_from": Timestamp.fromDate(DateTime(2024, 1, 1)),
    "valid_to": Timestamp.fromDate(DateTime(2024, 12, 31)),
    "menu_item": {
      "id": "item1",
      "name": "Big Burger",
      "description": "Tasty burger",
      "category": "Food",
      "imageUrl": "image.png",
      "price": 50,
      "newPrice": 40,
      "totalOrderCount": 100,
    },
  });

  final offers = await homeServices.getOffers().first;

  expect(offers.length, 1);
  expect(offers.first.discountPercent, 20);
  expect(offers.first.category, "Big Burger");
});





  test("getBestSellers() returns top ordered items", () async {
    final stream = homeServices.getBestSellers();
    final items = await stream.first;

    expect(items.length, 3);
    expect(items.first.name, "Pizza");
  });

  test("getMenuItems() returns all menu items", () async {
    final stream = homeServices.getMenuItems();
    final items = await stream.first;

    expect(items.length, 3);
  });

  test("getMenuItemsByCategory() returns only matching items", () async {
    final stream = homeServices.getMenuItemsByCategory("Fast Food");
    final items = await stream.first;

    expect(items.length, 2);
    expect(items.every((i) => i.category == "Fast Food"), true);
  });
}
