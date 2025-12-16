import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/presentation/theme/app_theme.dart';
import 'package:food_delivery_app/logic/cubit/user_cubit.dart';

/// Test helper utilities for widget testing
class TestHelpers {
  /// Pumps a widget wrapped with MaterialApp and necessary providers
  ///
  /// Usage:
  /// ```dart
  /// await tester.pumpWidget(TestHelpers.makeTestableWidget(MyWidget()));
  /// ```
  static Widget makeTestableWidget(
    Widget child, {
    UserCubit? userCubit,
    ThemeData? theme,
  }) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return BlocProvider<UserCubit>.value(
          value: userCubit ?? UserCubit(),
          child: MaterialApp(theme: theme ?? AppTheme.lightTheme, home: child),
        );
      },
    );
  }

  /// Pumps a widget with just MaterialApp (no providers)
  /// Useful for testing simple widgets that don't need Bloc
  static Widget makeSimpleTestableWidget(Widget child, {ThemeData? theme}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return MaterialApp(
          theme: theme ?? AppTheme.lightTheme,
          home: Scaffold(body: child),
        );
      },
    );
  }

  /// Creates a WidgetTester-friendly pumpWidget wrapper
  static Future<void> pumpTestWidget(
    WidgetTester tester,
    Widget widget, {
    UserCubit? userCubit,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      makeTestableWidget(widget, userCubit: userCubit, theme: theme),
    );
  }
}
