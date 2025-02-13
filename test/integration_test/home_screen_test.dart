import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/home_provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant_detail_provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant_favorite_provider.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';
import 'package:restaurant_dicoding_app/screens/home_screen.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';
import 'package:restaurant_dicoding_app/services/restaurant_favorite_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Screen Integration Test', () {
    testWidgets('should display home screen and navigate between tabs',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              Provider(create: (_) => RestaurantFavoriteService()..init()),
              Provider(create: (_) => LocalStorageService()..init()),
              ChangeNotifierProvider(
                create: (context) => RestaurantProvider(
                    favoriteService: context.read<RestaurantFavoriteService>()),
              ),
              ChangeNotifierProvider(
                create: (context) => RestaurantDetailProvider(
                  favoriteService: context.read<RestaurantFavoriteService>(),
                ),
              ),
              ChangeNotifierProvider(
                create: (context) {
                  return RestaurantFavoriteProvider(
                    context.read<RestaurantFavoriteService>(),
                  );
                },
              ),
              ChangeNotifierProvider(create: (_) => HomeProvider()),
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ],
            child: const HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify HomeScreen is displayed
      expect(find.byType(HomeScreen), findsOneWidget);

      // Verify BottomNavigationBar is present
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Tap on the Favorite tab
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pumpAndSettle();

      // Verify that the Favorite tab is now active
      expect(find.text('Favorite'), findsOneWidget);

      // Tap on the Settings tab
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      // Verify that the Settings tab is now active
      expect(find.text('Settings'), findsOneWidget);

      // Tap back to Home tab
      await tester.tap(find.byIcon(Icons.home_outlined));
      await tester.pumpAndSettle();

      // Verify that the Home tab is now active
      expect(find.text('Home'), findsOneWidget);
    });
  });
}
