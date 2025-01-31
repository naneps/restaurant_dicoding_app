// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_menu_item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantMenuItem _$RestaurantMenuItemFromJson(Map<String, dynamic> json) =>
    RestaurantMenuItem(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RestaurantMenuItemToJson(RestaurantMenuItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
