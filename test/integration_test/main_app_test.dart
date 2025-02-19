import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/main.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService().init();
  testWidgets('App should load and display home screen', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MainApp(),
      ),
    );

    await tester.pumpAndSettle(); // Tunggu hingga animasi selesai

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Dicoding Restaurant'), findsOneWidget);
  });
}
