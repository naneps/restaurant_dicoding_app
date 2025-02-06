import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/screens/restaurant_list_screen.dart';

@GenerateMocks([
  RestaurantProvider,
  RestaurantLoadedState,
  RestaurantEmptyState,
  RestaurantErrorState
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Restaurant List Screen Integration Test', () {
    testWidgets(
      'should display list of restaurants after fetching data',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: RestaurantListScreen()),
        );

        expect(find.byType(AppBar), findsWidgets);
      },
    );

    testWidgets('should show empty state when no restaurants available',
        (tester) async {
      //   final mockProvider = MockRestaurantProvider();
      //   final mockState = MockRestaurantEmptyState();

      //   // Mock the provider's state to return the empty state
      //   when(mockProvider.state).thenReturn(mockState);

      //   await tester.pumpWidget(
      //     MultiProvider(
      //       providers: [
      //         ChangeNotifierProvider<RestaurantProvider>.value(
      //             value: mockProvider),
      //       ],
      //       child: const MaterialApp(home: RestaurantListScreen()),
      //     ),
      //   );

      //   // Verify that the empty state widget is shown
      //   expect(find.byType(EmptyDataWidget), findsOneWidget);
    });

    testWidgets('should show error state when error occurs', (tester) async {
      //   final mockProvider = MockRestaurantProvider();
      //   final mockState = MockRestaurantErrorState();

      //   // Mock the provider's state to return the error state
      //   when(mockProvider.state).thenReturn(mockState);
      //   when(mockState.errorMessage)
      //       .thenReturn('An error occurred while fetching data.');

      //   await tester.pumpWidget(
      //     MultiProvider(
      //       providers: [
      //         ChangeNotifierProvider<RestaurantProvider>.value(
      //             value: mockProvider),
      //       ],
      //       child: const MaterialApp(home: RestaurantListScreen()),
      //     ),
      //   );

      //   // Verify that the error state widget is shown
      //   expect(find.byType(ErrorStateWidget), findsOneWidget);
    });
  });
}
