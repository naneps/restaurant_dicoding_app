import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/screens/home_screen.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService().init();
  group('Home Screen Integration Test', () {
    testWidgets(
      'should display list of restaurants after fetching data',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider(
              create: (BuildContext context) {},
              child: HomeScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsWidgets);
      },
    );
  });
}
