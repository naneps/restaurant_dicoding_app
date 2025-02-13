import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/main.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';

void main() {
  testWidgets('MainApp should have a title', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MainApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Dicoding Restaurant'), findsOneWidget);
  });

  testWidgets('MainApp should use light theme by default',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MainApp(),
      ),
    );

    await tester.pumpAndSettle();

    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.system);
  });

  testWidgets('MainApp should navigate to initial route',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MainApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(Navigator), findsOneWidget);
    expect(MainApp.navigatorKey.currentState?.canPop(), isFalse);
  });
}
