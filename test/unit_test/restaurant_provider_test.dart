import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/repositories/restaurant_repository.dart';
import 'package:restaurant_dicoding_app/services/restaurant_favorite_service.dart';

import '../mocks/restaurant_provider_test.mocks.dart';

@GenerateMocks([RestaurantRepository, RestaurantFavoriteService])
void main() {
  late MockRestaurantRepository mockRepo;
  late MockRestaurantFavoriteService mockFavoriteService;
  late RestaurantProvider provider;

  setUp(() {
    mockRepo = MockRestaurantRepository();
    mockFavoriteService = MockRestaurantFavoriteService();
    provider = RestaurantProvider(favoriteService: mockFavoriteService);
    provider.repo = mockRepo;
  });

  group('RestaurantProvider Tests', () {
    test('Initial state should be loading', () {
      expect(provider.state, isA<RestaurantLoadingState>());
    });

    test('getRestaurants should load restaurants successfully', () async {
      final mockRestaurants = [
        RestaurantModel(id: '1', name: 'Test Restaurant', isFavorite: false)
      ];

      when(mockRepo.getRestaurants()).thenAnswer((_) async => mockRestaurants);
      when(mockFavoriteService.getFavorites()).thenAnswer((_) async => []);

      await provider.getRestaurants();

      expect(provider.state, isA<RestaurantLoadedState>());
      final loadedState = provider.state as RestaurantLoadedState;
      expect(loadedState.restaurants.length, 1);
      expect(loadedState.restaurants.first.name, 'Test Restaurant');
    });

    test('getRestaurants should set empty state if no data', () async {
      when(mockRepo.getRestaurants()).thenAnswer((_) async => []);

      await provider.getRestaurants();

      expect(provider.state, isA<RestaurantEmptyState>());
    });

    test('getRestaurants should set error state if failed', () async {
      when(mockRepo.getRestaurants()).thenThrow(Exception('Network Error'));

      await provider.getRestaurants();

      expect(provider.state, isA<RestaurantErrorState>());
      final errorState = provider.state as RestaurantErrorState;
      expect(errorState.errorMessage, contains('Failed to fetch restaurants'));
    });

    test('searchRestaurants should load search results', () async {
      final mockRestaurants = [
        RestaurantModel(id: '1', name: 'Test Restaurant', isFavorite: false)
      ];

      when(mockRepo.searchRestaurants('Test'))
          .thenAnswer((_) async => mockRestaurants);

      provider.searchRestaurants('Test');

      await Future.delayed(const Duration(milliseconds: 600));

      expect(provider.state, isA<RestaurantLoadedState>());
      final loadedState = provider.state as RestaurantLoadedState;
      expect(loadedState.restaurants.length, 1);
      expect(loadedState.restaurants.first.name, 'Test Restaurant');
    });

    test('toggleFavorite should update restaurant favorite status', () async {
      final restaurant =
          RestaurantModel(id: '1', name: 'Test', isFavorite: false);

      when(mockFavoriteService.insertFavorite(restaurant))
          .thenAnswer((_) async {
        return;
      });
      when(mockFavoriteService.deleteFavorite(restaurant.id!))
          .thenAnswer((_) async {
        return;
      });

      provider.toggleFavorite(restaurant);

      await Future.delayed(const Duration(milliseconds: 100));

      verify(mockFavoriteService.insertFavorite(restaurant)).called(1);
    });
  });
}
