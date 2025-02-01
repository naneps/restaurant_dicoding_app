import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/repositories/restaurant_repository.dart';
import 'package:restaurant_dicoding_app/services/restaurant_favorite_service.dart';
import 'package:restaurant_dicoding_app/services/restaurant_service.dart';

void main() {
  late RestaurantProvider provider;
  late MockRestaurantRepository mockRepository;
  late MockRestaurantService mockService;

  setUp(() {
    mockRepository = MockRestaurantRepository();
    mockService = MockRestaurantService();
    mockService.baseUrl = 'https://restaurant-api.dicoding.dev';
    mockRepository.service = mockService;
    provider = RestaurantProvider(
      favoriteService: MockRestaurantFavoriteService(),
    )..repo = mockRepository;
  });

  group(
    "RestaurantService Test",
    () {
      setUp(() {
        mockService = MockRestaurantService();
        mockService.baseUrl = 'https://restaurant-api.dicoding.dev';
      });

      test('getRestaurants should return a list of restaurants', () async {
        when(mockService.getRestaurants()).thenAnswer((_) async {
          return Response('{"restaurants": []}', 200);
        });
      });
    },
  );
  group('RestaurantProvider Tests', () {
    test('Initial state should be RestaurantLoadingState', () {
      expect(provider.state, isA<RestaurantLoadingState>());
    });

    test('getRestaurants should fetch and set restaurants', () async {
      when(mockRepository.getRestaurants()).thenAnswer((_) async {
        return <RestaurantModel>[];
      });

      await provider.getRestaurants();

      expect(provider.state, isA<RestaurantLoadedState>());
    });
    test('toggleShowFieldReview should toggle the showFieldReview flag', () {
      //   expect(provider.showFieldReview, false);

      //   //   provider.toggleShowFieldReview();

      //   expect(provider.showFieldReview, true);

      //   //   provider.toggleShowFieldReview();

      //   expect(provider.showFieldReview, false);
    });
  });
}

class MockRestaurantFavoriteService extends Mock
    implements RestaurantFavoriteService {}

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

class MockRestaurantService extends Mock implements RestaurantService {}
