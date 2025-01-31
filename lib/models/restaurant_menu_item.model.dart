import 'package:json_annotation/json_annotation.dart';

part 'restaurant_menu_item.model.g.dart';

@JsonSerializable()
class RestaurantMenuItem {
  final String? name;
  final double? price; // Specific attribute for menu items
  const RestaurantMenuItem({this.name, this.price});
  factory RestaurantMenuItem.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantMenuItemToJson(this);
}
