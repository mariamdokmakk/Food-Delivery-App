import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/presentation/widgets/empty_state_widget.dart';
import '../test_helpers.dart';

void main() {
  group('EmptyStateWidget', () {
    testWidgets('displays title and subtitle correctly', (
      WidgetTester tester,
    ) async {
      const testTitle = 'No Items Found';
      const testSubtitle = 'Try adding some items';

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const EmptyStateWidget(title: testTitle, subtitle: testSubtitle),
        ),
      );

      // Verify title is displayed
      expect(find.text(testTitle), findsOneWidget);

      // Verify subtitle is displayed
      expect(find.text(testSubtitle), findsOneWidget);
    });

    testWidgets('displays default icon when no icon provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const EmptyStateWidget(title: 'Empty', subtitle: 'No data'),
        ),
      );

      // Verify default icon is displayed
      expect(find.byIcon(Icons.description_outlined), findsWidgets);
    });

    testWidgets('displays custom icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const EmptyStateWidget(
            title: 'No Orders',
            subtitle: 'Start ordering food',
            icon: Icons.shopping_cart_outlined,
          ),
        ),
      );

      // Verify custom icon is displayed
      expect(find.byIcon(Icons.shopping_cart_outlined), findsWidgets);
    });

    testWidgets('widget is centered', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const EmptyStateWidget(title: 'Test', subtitle: 'Test subtitle'),
        ),
      );

      // Verify Center widget exists
      expect(find.byType(Center), findsWidgets);
    });
  });
}
