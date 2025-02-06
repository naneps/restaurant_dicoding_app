import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_dicoding_app/repositories/restaurant_repository.dart';
import 'package:restaurant_dicoding_app/services/restaurant_service.dart';

import '../mocks/restaurant_repository_test.mocks.dart';

@GenerateMocks([RestaurantService])
void main() {
  late MockRestaurantService mockService;
  late RestaurantRepository repository;

  setUp(() {
    mockService = MockRestaurantService();
    repository = RestaurantRepository();
    repository.service = mockService;
  });

  group('RestaurantRepository Tests', () {
    test('getRestaurants should return a list of restaurants', () async {
      final mockResponse = {
        'restaurants': [
          {'id': '1', 'name': 'Test Restaurant', 'description': 'Good Food'}
        ]
      };

      when(mockService.getRestaurants()).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      final result = await repository.getRestaurants();

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.name, 'Test Restaurant');
    });

    test('getRestaurant should return a restaurant by id', () async {
      final mockResponse = {
        'restaurant': {
          'id': '1',
          'name': 'Test Restaurant',
          'description': 'Good Food'
        }
      };

      when(mockService.getRestaurant('1')).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      final result = await repository.getRestaurant('1');

      expect(result, isNotNull);
      expect(result!.name, 'Test Restaurant');
    });

    test('searchRestaurants should return matching restaurants', () async {
      final mockResponse = {
        'restaurants': [
          {'id': '1', 'name': 'Test Restaurant', 'description': 'Good Food'}
        ]
      };

      when(mockService.searchRestaurants('Test')).thenAnswer(
        (_) async => http.Response(
          jsonEncode(mockResponse),
          200,
        ),
      );

      final result = await repository.searchRestaurants('Test');

      expect(result, isNotNull);
      expect(result!.isNotEmpty, true);
      expect(result.first.name, contains('Test'));
    });

    test('addReview should call service with correct parameters', () async {
      when(mockService.addReview(id: '1', name: 'John Doe', review: 'Great!'))
          .thenAnswer(
        (_) async => http.Response('', 200),
      );

      await repository.addReview(id: '1', name: 'John Doe', review: 'Great!');

      verify(mockService.addReview(id: '1', name: 'John Doe', review: 'Great!'))
          .called(1);

      verifyNoMoreInteractions(mockService);
    });

    test('getRestaurants should return an empty list if response is not 200',
        () async {
      when(mockService.getRestaurants())
          .thenAnswer((_) async => http.Response('Error', 400));

      final result = await repository.getRestaurants();

      expect(result, isEmpty);
    });
  });
}
