import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:food_delivery_app/data/models/menu_item.dart';
import 'package:food_delivery_app/data/models/order.dart';


import 'test services/order_services_test.dart';

void main() {
  late FakeFirebaseFirestore fakeDb;
  late OrderServicesTest service;
  const userId = "testUser";

  setUp(() {
    fakeDb = FakeFirebaseFirestore();
    service = OrderServicesTest(db: fakeDb, userId: userId);
  });

  OrderItem buildOrder({
    required String id,
    required String state,
  }) {
    return OrderItem(
      id: id,
      userId: userId,
      orderId: 1,
      items: [],
      totalPrice: 0,
      orderState: state,
      address: "Giza",
      createdAt: DateTime.now(),
    );
  }

  test("cancelOrder() updates orderState to cancelled", () async {
    final order = buildOrder(id: "o1", state: "pending");

    await fakeDb
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(order.id)
        .set(order.toMap());

    await service.cancelOrder(order);

    final snap = await fakeDb
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(order.id)
        .get();

    expect(snap.data()!["orderState"], "cancelled");
  });

  test("getActiveOrders() returns pending/preparing/onTheWay", () async {
  await fakeDb
      .collection("users")
      .doc(userId)
      .collection("Orders")
      .doc("1")
      .set(buildOrder(id: "1", state: "pending").toMap());

  await fakeDb
      .collection("users")
      .doc(userId)
      .collection("Orders")
      .doc("2")
      .set(buildOrder(id: "2", state: "completed").toMap());

  final result = await service.getActiveOrders().first;

  expect(result.length, 1);
  expect(result.first.orderState, "pending");
});


  test("getCompletedOrders() returns only completed items", () async {
  await fakeDb
      .collection("users")
      .doc(userId)
      .collection("Orders")
      .doc("1")
      .set(buildOrder(id: "1", state: "completed").toMap());

  await fakeDb
      .collection("users")
      .doc(userId)
      .collection("Orders")
      .doc("2")
      .set(buildOrder(id: "2", state: "pending").toMap());

  final result = await service.getCompletedOrders().first;

  expect(result.length, 1);
  expect(result.first.orderState, "completed");
});


  test("getCancelledOrders() returns only cancelled items", () async {
  await fakeDb
      .collection("users")
      .doc(userId)
      .collection("Orders")
      .doc("1")
      .set(buildOrder(id: "1", state: "cancelled").toMap());

  await fakeDb
      .collection("users")
      .doc(userId)
      .collection("Orders")
      .doc("2")
      .set(buildOrder(id: "2", state: "pending").toMap());

  final result = await service.getCancelledOrders().first;

  expect(result.length, 1);
  expect(result.first.orderState, "cancelled");
});


  test("calcTotalPrice() sums item prices and updates totalPrice", () async {
    final order = buildOrder(id: "444", state: "pending");

    await fakeDb
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(order.id)
        .set(order.toMap());

    await fakeDb
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(order.id)
        .collection("items")
        .add(MenuItem(id: "1", name: "Burger", price: 30, description: '', category: '', imageUrl: '', totalOrderCount: 0,newPrice: 0).toMap());

    await fakeDb
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(order.id)
        .collection("items")
        .add(MenuItem(id: "2", name: "Fries", price: 20, description: '', category: '', imageUrl: '', totalOrderCount: 0, newPrice: 0).toMap());

    final total = await service.calcTotalPrice(order);

    expect(total, 50);

    final updated = await fakeDb
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(order.id)
        .get();

    expect(updated.data()!["totalPrice"], 50);
  });
}
