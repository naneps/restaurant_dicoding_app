import 'package:http/http.dart' as http;
import 'package:restaurant_dicoding_app/constants/app_constants.dart';
import 'package:restaurant_dicoding_app/services/api_services.dart';

class RestaurantService extends ApiService {
  RestaurantService() : super(baseUrl: baseUrl);
  Future<http.Response> addReview({required String id, name, review}) {
    return post(
      '/review',
      body: {'id': id, 'name': name, 'review': review},
    );
  }

  Future<http.Response> getRestaurant(String id) => get('/detail/$id');
  Future<http.Response> getRestaurants() => get('/list');

  Future<http.Response> getRestaurantsByCity(String city) {
    return get(
      '/list',
      queryParameters: {'city': city},
    );
  }
}
