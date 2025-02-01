// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      pictureId: json['pictureId'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      //   categories: RestaurantModel._categoriesFromJson(json['categories']),
      //   menus: RestaurantModel._menusFromJson(json['menus']),
      //   customerReviews:
      //       RestaurantModel._reviewsFromJson(json['customerReviews']),
      //   isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'address': instance.address,
      'pictureId': instance.pictureId,
      'rating': instance.rating,
      'isFavorite': instance.isFavorite,
      'categories': RestaurantModel._categoriesToJson(instance.categories),
      'menus': RestaurantModel._menusToJson(instance.menus),
      'customerReviews':
          RestaurantModel._reviewsToJson(instance.customerReviews),
    };
