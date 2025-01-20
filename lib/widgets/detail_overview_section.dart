part of '../screens/restaurant_detail_screen.dart';

class DetailOverViewSection extends StatelessWidget {
  final RestaurantModel restaurant;
  const DetailOverViewSection({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: Theme.of(context).textTheme.titleSmall,
            ),
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
      ),
    );
  }
}
