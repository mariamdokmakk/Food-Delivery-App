import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/presentation/widgets/menu_item_tile.dart';
import '../test_helpers.dart';
import '../mock_data.dart';

void main() {
  group('MenuItemTile', () {
    testWidgets('displays menu item name', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem(name: 'Cheeseburger');

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(MenuItemTile(menuItem: menuItem)),
      );

      expect(find.text('Cheeseburger'), findsOneWidget);
    });

    testWidgets('displays menu item price', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem(price: 8.99);

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(MenuItemTile(menuItem: menuItem)),
      );

      expect(find.text('\$8.99'), findsOneWidget);
    });

    testWidgets('displays image container', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem();

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(MenuItemTile(menuItem: menuItem)),
      );

      // Should have a container for the image
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('renders as ListTile', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem();

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(MenuItemTile(menuItem: menuItem)),
      );

      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('displays different menu items correctly', (
      WidgetTester tester,
    ) async {
      final items = [
        MockData.sampleMenuItem(name: 'Pizza', price: 12.99),
        MockData.sampleMenuItem(name: 'Pasta', price: 10.99),
        MockData.sampleMenuItem(name: 'Salad', price: 7.99),
      ];

      for (final item in items) {
        await tester.pumpWidget(
          TestHelpers.makeSimpleTestableWidget(MenuItemTile(menuItem: item)),
        );

        expect(find.text(item.name), findsOneWidget);
        expect(find.text('\$${item.price}'), findsOneWidget);
      }
    });
  });
}
