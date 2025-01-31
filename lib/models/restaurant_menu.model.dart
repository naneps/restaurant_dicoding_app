import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_dicoding_app/models/restaurant_menu_item.model.dart';

part 'restaurant_menu.model.g.dart';

@JsonSerializable()
class RestaurantMenu {
  List<RestaurantMenuItem>? foods;
  List<RestaurantMenuItem>? drinks;

  RestaurantMenu({this.foods, this.drinks});

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMenuFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantMenuToJson(this);
}
