import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_dicoding_app/services/restaurant_service.dart';

@GenerateMocks([http.Client])
void main() {
  late RestaurantService restaurantService;
  setUp(() {
    restaurantService = RestaurantService();
    restaurantService.baseUrl = 'https://restaurant-api.dicoding.dev';
  });

  group('RestaurantService', () {
    test('addReview returns a successful response', () async {
      //   final response = http.Response('{"message": "success"}', 200);
      //   when(mockClient.post(
      //     Uri.parse('${restaurantService.baseUrl}/review'),
      //     body: {'id': '1', 'name': 'John Doe', 'review': 'Great!'},
      //   )).thenAnswer((_) async => response);

      final result = await restaurantService.addReview(
          id: '1', name: 'John Doe', review: 'Great!');
      expect(result.statusCode, 200);
      expect(result.body, '{"message": "success"}');
    });

    test('getRestaurant returns a successful response', () async {
      final result = await restaurantService.getRestaurant('1');
      expect(result, isA<http.Response>());
      //   expect(result.body, '{"id": "1", "name": "Restaurant"}');
    });

    test("getRestaurant return not found or exception", () async {
      when(restaurantService.getRestaurant('1')).thenAnswer(
        (_) async => http.Response('{"error": "not found"}', 404),
      );
    });

    test('getRestaurants returns a successful response', () async {
      //   final response = http.Response('{"restaurants": []}', 200);
      //   when(mockClient.get(Uri.parse('${restaurantService.baseUrl}/list')))
      //       .thenAnswer((_) async => response);

      final result = await restaurantService.getRestaurants();
      expect(result.statusCode, 200);
      expect(result.body, '{"restaurants": []}');
    });

    test('searchRestaurants returns a successful response', () async {
      final result = await restaurantService.searchRestaurants('test');
      expect(result.statusCode, 200);
      expect(result.body, '{"restaurants": []}');
    });
  });
}
