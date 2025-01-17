part of '../screens/restaurant_detail_screen.dart';

class RestaurantReviewSection extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantReviewSection({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(builder: (context, provider, child) {
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
                icon: Icon(provider.showFieldReview ? Icons.cancel : Icons.add),
                label: Text(
                  provider.showFieldReview ? 'Cancel' : 'Add Review',
                ),
              )
            ],
          ),
          if (provider.showFieldReview) ...[
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: provider.formKey,
                    child: TextFormField(
                      controller: provider.reviewController,
                      maxLines: 5,
                      minLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Write your review',
                        constraints: const BoxConstraints(minHeight: 50),
                        contentPadding: const EdgeInsets.all(10),
                        suffixIconColor: Theme.of(context).colorScheme.primary,
                        suffixIcon: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: const Size(0, 0),
                            fixedSize: const Size(20, 20),
                            backgroundColor: Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (provider.formKey.currentState!.validate()) {
                              provider.addReview(id: restaurant.id!);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
        ],
      );
    });
  }
}
