import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/widgets/restaurant_grid_item.dart';

void main() {
  late RestaurantModel restaurant;

  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  setUp(() {
    restaurant = RestaurantModel(
      id: '1',
      name: 'Test Restaurant',
      pictureId: '14',
      city: 'Test City',
      rating: 4.5,
      isFavorite: false,
    );
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      home: Scaffold(
        body: RestaurantGridItem(restaurant: restaurant),
      ),
    );
  }

  group('Restaurant Grid Item', () {
    testWidgets('should display restaurant name', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Test Restaurant'), findsOneWidget);
    });

    testWidgets('should display restaurant city', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Test City'), findsOneWidget);
    });

    testWidgets('should display restaurant rating', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('4.5'), findsOneWidget);
    });

    testWidgets('should display restaurant picture', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();
      expect(find.byType(Image), findsOneWidget);
    });
  });
}

class MockHttpOverrides extends HttpOverrides {}
