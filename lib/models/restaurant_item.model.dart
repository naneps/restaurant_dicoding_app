sealed class Item {
  final String? name;
  const Item({this.name});
}

class RestaurantCategory extends Item {
  const RestaurantCategory({super.name});

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) {
    return RestaurantCategory(
      name: json['name'],
    );
  }
}

class RestaurantMenu extends Item {
  final double? price; // Specific attribute for menu items

  const RestaurantMenu({super.name, this.price});

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) {
    return RestaurantMenu(
      name: json['name'],
      price: json['price']?.toDouble(), // Handle optional price attribute
    );
  }
}
