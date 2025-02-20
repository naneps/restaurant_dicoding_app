import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/main.dart';
import 'package:restaurant_dicoding_app/providers/home_provider.dart';
import 'package:restaurant_dicoding_app/screens/home_screen.dart';
import 'package:restaurant_dicoding_app/screens/splash_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late Widget app;

  setUp(() {
    app = const MainApp();
  });

  group('MainApp Tests', () {
    testWidgets('should load properly', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      expect(find.byType(MainApp), findsOneWidget);
    });

    testWidgets('should navigate from SplashScreen to HomeScreen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(app);
      expect(find.byType(SplashScreen), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  group('HomeScreen Tests', () {
    testWidgets('should load properly', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('HomeScreen should navigate pages using BottomNavigationBar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MainApp());

      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      expect(find.byType(BottomNavigationBar), findsOneWidget);

      final Finder bottomNavBar = find.byType(BottomNavigationBar);

      final homeProvider = Provider.of<HomeProvider>(
        tester.element(find.byType(HomeScreen)),
        listen: false,
      );
      expect(homeProvider.activeIndex, 0);

      await tester.tap(
        find.descendant(
          of: bottomNavBar,
          matching: find.byIcon(Icons.favorite_border),
        ),
      );
      await tester.pumpAndSettle();

      expect(homeProvider.activeIndex, 1);

      await tester.tap(
        find.descendant(
          of: bottomNavBar,
          matching: find.byIcon(Icons.settings_outlined),
        ),
      );
      await tester.pumpAndSettle();

      expect(homeProvider.activeIndex, 2);
    });
  });
}

Future<void> tapBottomNavItem(
  WidgetTester tester,
  IconData icon,
  int index,
) async {
  await tester.tap(find.byIcon(icon).at(index));
  await tester.pumpAndSettle();
}
