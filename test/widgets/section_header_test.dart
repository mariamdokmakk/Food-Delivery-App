import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/presentation/widgets/section_header.dart';
import '../test_helpers.dart';

void main() {
  group('SectionHeader', () {
    testWidgets('displays title correctly', (WidgetTester tester) async {
      const testTitle = 'Featured Restaurants';

      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const SectionHeader(title: testTitle),
        ),
      );

      // Verify title is displayed
      expect(find.text(testTitle), findsOneWidget);
    });

    testWidgets('applies correct text style', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestHelpers.makeSimpleTestableWidget(
          const SectionHeader(title: 'Test Title'),
        ),
      );

      // Find the Text widget
      final textWidget = tester.widget<Text>(find.byType(Text));

      // Verify text style properties
      expect(textWidget.style?.fontSize, 20);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('renders different titles correctly', (
      WidgetTester tester,
    ) async {
      const titles = ['Popular', 'Nearby', 'Recommended'];

      for (final title in titles) {
        await tester.pumpWidget(
          TestHelpers.makeSimpleTestableWidget(SectionHeader(title: title)),
        );

        expect(find.text(title), findsOneWidget);
      }
    });
  });
}
