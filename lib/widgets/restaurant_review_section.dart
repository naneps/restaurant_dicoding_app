part of '../screens/restaurant_detail_screen.dart';

class RestaurantReviewSection extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantReviewSection({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Consumer<RestaurantProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${restaurant.customerReviews!.length} People Reviews",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextButton.icon(
                  onPressed: () {
                    provider.toggleShowFieldReview();
                  },
                  icon:
                      Icon(provider.showFieldReview ? Icons.cancel : Icons.add),
                  label: Text(
                    provider.showFieldReview ? 'Cancel' : 'Add Review',
                  ),
                )
              ],
            ),
            if (provider.showFieldReview) ...[
              Expanded(
                child: FieldReview(restaurant: restaurant),
              ),
            ],
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: restaurant.customerReviews!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(restaurant.customerReviews![index].name!),
                  subtitle: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableText(
                        restaurant.customerReviews![index].review!,
                        expandText: "Show More",
                        collapseText: "Show Less",
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 4,
                      ),
                      Text(
                        restaurant.customerReviews![index].date!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade500,
                            ),
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://avatar.iran.liara.run/public/$index",
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
