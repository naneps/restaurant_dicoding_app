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
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        collapsedShape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none),
        ),
        collapsedBackgroundColor:
            Theme.of(context).colorScheme.surfaceContainer,
        shape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none),
        ),
        childrenPadding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth ~/ 150,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return MenuWidget(item: item);
              },
            );
          })
        ],
      );
    }

    return Padding(
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
    );
  }
}
