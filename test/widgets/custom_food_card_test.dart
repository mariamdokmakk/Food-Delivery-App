import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/presentation/widgets/custom_food_card.dart';
import '../test_helpers.dart';
import '../mock_data.dart';

void main() {
  group('CustomFoodCard', () {
    testWidgets('displays item name', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem(name: 'Pepperoni Pizza');

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(CustomFoodCard(item: menuItem)),
      );

      expect(find.text('Pepperoni Pizza'), findsOneWidget);
    });

    testWidgets('displays item description', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem(
        description: 'Delicious pizza with tomato and cheese',
      );

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(CustomFoodCard(item: menuItem)),
      );

      expect(
        find.text('Delicious pizza with tomato and cheese'),
        findsOneWidget,
      );
    });

    testWidgets('displays item price formatted correctly', (
      WidgetTester tester,
    ) async {
      final menuItem = MockData.sampleMenuItem(price: 15.50);

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(CustomFoodCard(item: menuItem)),
      );

      expect(find.text('\$15.50'), findsOneWidget);
    });

    testWidgets('displays favorite icon button', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem();

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(CustomFoodCard(item: menuItem)),
      );

      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('renders as a Card', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem();

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(CustomFoodCard(item: menuItem)),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('displays image network widget', (WidgetTester tester) async {
      final menuItem = MockData.sampleMenuItem(
        imageUrl: 'https://example.com/food.jpg',
      );

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(CustomFoodCard(item: menuItem)),
      );

      expect(find.byType(Image), findsOneWidget);
    });
  });
}
