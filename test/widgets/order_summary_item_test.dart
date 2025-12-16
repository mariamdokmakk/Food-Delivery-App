import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/presentation/widgets/order_summary_item.dart';
import '../test_helpers.dart';

void main() {
  group('OrderSummaryItem', () {
    testWidgets('displays title and price', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const OrderSummaryItem(title: 'Margherita Pizza', price: '\$12.99'),
        ),
      );

      expect(find.text('Margherita Pizza'), findsOneWidget);
      expect(find.text('\$12.99'), findsOneWidget);
    });

    testWidgets('displays quantity badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const OrderSummaryItem(title: 'Burger', price: '\$8.99'),
        ),
      );

      expect(find.text('1x'), findsOneWidget);
    });

    testWidgets('displays edit icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const OrderSummaryItem(title: 'Salad', price: '\$6.99'),
        ),
      );

      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('renders as ListTile', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const OrderSummaryItem(title: 'Pasta', price: '\$10.99'),
        ),
      );

      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('displays image placeholder container', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const OrderSummaryItem(title: 'Fries', price: '\$3.99'),
        ),
      );

      // Container for the image placeholder should exist
      expect(find.byType(Container), findsWidgets);
    });
  });
}
