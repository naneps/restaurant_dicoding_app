part of '../screens/restaurant_detail_screen.dart';

class RestaurantMenuSection extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantMenuSection({
    required this.restaurant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget _buildMenuSection({
      required String title,
      required IconData icon,
      required List<RestaurantMenu> items,
    }) {
      return ExpansionTile(
        title: Text(title),
        visualDensity: VisualDensity.compact,
        leading: Icon(icon),
        collapsedShape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none),
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none),
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                title: Text(item.name!),
              );
            },
          ),
        ],
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView(
          //   spacing: 10,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuSection(
              title: "Foods (${restaurant.menus!.foods!.length})",
              icon: Icons.fastfood,
              items: restaurant.menus!.foods!,
            ),
            _buildMenuSection(
              title: "Drinks (${restaurant.menus!.drinks!.length})",
              icon: Icons.local_drink,
              items: restaurant.menus!.drinks!,
            ),
          ],
        ),
      ),
    );
  }
}
