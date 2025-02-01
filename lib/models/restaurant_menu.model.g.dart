// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_menu.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantMenu _$RestaurantMenuFromJson(Map<String, dynamic> json) =>
    RestaurantMenu(
      foods: (json['foods'] as List<dynamic>?)
          ?.map((e) => RestaurantMenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>?)
          ?.map((e) => RestaurantMenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantMenuToJson(RestaurantMenu instance) =>
    <String, dynamic>{
      'foods': RestaurantMenu._foodsToJson(instance.foods),
      'drinks': RestaurantMenu._drinksToJson(instance.drinks),
    };
