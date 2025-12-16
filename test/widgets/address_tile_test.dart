import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/presentation/widgets/address_tile.dart';
import '../test_helpers.dart';

void main() {
  group('AddressTile', () {
    testWidgets('displays title and address', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          AddressTile(
            title: 'Home',
            address: '123 Main St',
            icon: Icons.home,
            onTap: () {},
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('123 Main St'), findsOneWidget);
    });

    testWidgets('displays icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          AddressTile(
            title: 'Office',
            address: '456 Work Ave',
            icon: Icons.business,
            onTap: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.business), findsOneWidget);
    });

    testWidgets('shows default badge when isDefault is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          AddressTile(
            title: 'Home',
            address: '123 Main St',
            icon: Icons.home,
            isDefault: true,
            onTap: () {},
          ),
        ),
      );

      expect(find.text('Default'), findsOneWidget);
    });

    testWidgets('does not show default badge when isDefault is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          AddressTile(
            title: 'Work',
            address: '456 Office Blvd',
            icon: Icons.work,
            isDefault: false,
            onTap: () {},
          ),
        ),
      );

      expect(find.text('Default'), findsNothing);
    });

    testWidgets('triggers onTap callback when tapped', (
      WidgetTester tester,
    ) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          AddressTile(
            title: 'Home',
            address: '123 Main St',
            icon: Icons.home,
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));
      expect(wasTapped, true);
    });

    testWidgets('applies different border when selected', (
      WidgetTester tester,
    ) async {
      // Test selected state
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          AddressTile(
            title: 'Home',
            address: '123 Main St',
            icon: Icons.home,
            isSelected: true,
            onTap: () {},
          ),
        ),
      );

      final selectedCard = tester.widget<Card>(find.byType(Card));
      final selectedShape = selectedCard.shape as RoundedRectangleBorder;
      expect(selectedShape.side.width, 1.5);

      // Test non-selected state
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          AddressTile(
            title: 'Home',
            address: '123 Main St',
            icon: Icons.home,
            isSelected: false,
            onTap: () {},
          ),
        ),
      );

      final unselectedCard = tester.widget<Card>(find.byType(Card));
      final unselectedShape = unselectedCard.shape as RoundedRectangleBorder;
      expect(unselectedShape.side.width, 1);
    });
  });
}
