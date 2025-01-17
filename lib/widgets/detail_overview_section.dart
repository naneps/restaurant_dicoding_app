part of '../screens/restaurant_detail_screen.dart';

class DetailOverViewSection extends StatelessWidget {
  final RestaurantModel restaurant;
  const DetailOverViewSection({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tooltip(
            message: "Categories",
            child: Wrap(
              spacing: 5,
              children: [
                ...restaurant.categories!.map(
                  (category) => Chip(
                    label: Text(category.name!),
                    visualDensity: VisualDensity.compact,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Description",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          ExpandableText(
            restaurant.description!,
            expandText: "Read more",
            collapseText: "Show less",
            maxLines: 5,
            animation: true,
          ),
        ],
      ),
    );
  }
}
