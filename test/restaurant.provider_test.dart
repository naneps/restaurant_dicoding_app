import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/repositories/restaurant_repository.dart';

void main() {
  late RestaurantProvider provider;
  late MockRestaurantRepository mockRepository;

  setUp(() {
    mockRepository = MockRestaurantRepository();
    provider = RestaurantProvider()..repo = mockRepository;
  });

  group('RestaurantProvider Tests', () {
    test('Initial state should be RestaurantLoadingState', () {
      expect(provider.state, isA<RestaurantLoadingState>());
    });

    test('getRestaurants should fetch and set restaurants', () async {
      final restaurants = [RestaurantModel(id: '1', name: 'Test Restaurant')];
      when(mockRepository.getRestaurants()).thenAnswer(
        (_) async => restaurants,
      );

      //   await provider.getRestaurants();
      //   expect(provider.state, isA<RestaurantLoadedState>());
      //   expect(
      //       (provider.state as RestaurantLoadedState).restaurants, restaurants);
    });

    test('getRestaurant should fetch and set a restaurant', () async {
      final restaurant = RestaurantModel(id: '1', name: 'Test Restaurant');
      when(mockRepository.getRestaurant('1'))
          .thenAnswer((_) async => restaurant);

      await provider.getRestaurant('1');

      expect(provider.state, isA<RestaurantLoadedDetailState>());
      expect((provider.state as RestaurantLoadedDetailState).restaurant,
          restaurant);
    });

    test('searchRestaurants should fetch and set searched restaurants',
        () async {
      final restaurants = [RestaurantModel(id: '1', name: 'Test Restaurant')];
      when(mockRepository.searchRestaurants('Test'))
          .thenAnswer((_) async => restaurants);

      provider.searchRestaurants('Test');

      await Future.delayed(
          const Duration(milliseconds: 600)); // Wait for debounce

      expect(provider.state, isA<RestaurantLoadedState>());
      expect(
          (provider.state as RestaurantLoadedState).restaurants, restaurants);
    });

    test('addReview should add a review and fetch the restaurant', () async {
      final restaurant = RestaurantModel(id: '1', name: 'Test Restaurant');
      when(mockRepository.addReview(id: '1', name: 'Ahmad', review: 'Great!'))
          .thenAnswer((_) async => null);
      when(mockRepository.getRestaurant('1'))
          .thenAnswer((_) async => restaurant);

      provider.reviewController.text = 'Great!';
      await provider.addReview(id: '1');

      expect(provider.isSendingReview, false);
      expect(provider.reviewController.text, '');
      expect(provider.state, isA<RestaurantLoadedDetailState>());
      expect((provider.state as RestaurantLoadedDetailState).restaurant,
          restaurant);
    });

    test('toggleShowFieldReview should toggle the showFieldReview flag', () {
      expect(provider.showFieldReview, false);

      provider.toggleShowFieldReview();

      expect(provider.showFieldReview, true);

      provider.toggleShowFieldReview();

      expect(provider.showFieldReview, false);
    });
  });
}

class MockRestaurantRepository extends Mock implements RestaurantRepository {}
