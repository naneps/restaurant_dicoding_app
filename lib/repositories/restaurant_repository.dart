import 'dart:convert';

import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/services/restaurant_service.dart';

class RestaurantRepository {
  RestaurantService service = RestaurantService();
  Future<void> addReview({required String id, name, review}) async {
    try {
      await service.addReview(id: id, name: name, review: review);
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantModel?> getRestaurant(String id) async {
    try {
      final response = await service.getRestaurant(id);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['restaurant'];
        return RestaurantModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RestaurantModel>?> getRestaurants() async {
    try {
      final response = await service.getRestaurants();
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['restaurants'];

        return data
            .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RestaurantModel>?> searchRestaurants(String value) async {
    try {
      final response = await service.searchRestaurants(value);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['restaurants'];

        return data
            .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
