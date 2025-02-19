import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/constants/app_routes.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart'; // Sesuaikan dengan nama provider
import 'package:restaurant_dicoding_app/screens/splash_screen.dart'; // Sesuaikan dengan struktur proyek

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SplashScreen navigates to Home after delay',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) =>
                  ThemeProvider()), // Pastikan ThemeProvider tersedia
        ],
        child: MaterialApp(
          initialRoute: AppRoutes.splashRoute,
          routes: {
            AppRoutes.splashRoute: (context) => SplashScreen(),
            AppRoutes.homeRoute: (context) => Scaffold(
                  key: Key(AppRoutes.homeRoute),
                  body: Text('Home Screen'),
                ),
          },
        ),
      ),
    );

    // Verifikasi apakah widget SplashScreen muncul
    expect(find.byType(SplashScreen), findsOneWidget);

    // Tunggu durasi splash screen selesai
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verifikasi apakah sudah berpindah ke halaman Home
    expect(find.byKey(Key(AppRoutes.homeRoute)), findsOneWidget);
  });
}
