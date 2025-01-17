import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/filter_provider.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context, provider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  "Filter",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  "Distance",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: provider.selectedDistance,
                  items: ['Farthest', 'Nearest']
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    provider.setDistance(value!);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Price Range Filter
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price Range",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                RangeSlider(
                  values: provider.priceRange,
                  min: 0,
                  max: 500,
                  divisions: 50,
                  labels: RangeLabels(
                    '\$${provider.priceRange.start.toInt()}',
                    '\$${provider.priceRange.end.toInt()}',
                  ),
                  onChanged: provider.setPriceRange,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${provider.priceRange.start.toInt()}'),
                    Text('\$${provider.priceRange.end.toInt()}'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Food Type Filter
            Row(
              children: [
                Text(
                  "Food Type",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: provider.selectedFoodType,
                  items: ['All', 'Western', 'Asian', 'Fast Food', 'Dessert']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    provider.setFoodType(value!);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Restaurant Type Filter
            Row(
              children: [
                Text(
                  "Restaurant Type",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: provider.selectedRestaurantType,
                  items: ['All', 'Cafe', 'Fine Dining', 'Street Food']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    provider.setRestaurantType(value!);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Apply and Reset Buttons

            ElevatedButton(
              onPressed: () {
                print('Filters applied:');
                print('Distance: ${provider.selectedDistance}');
                print(
                    'Price Range: ${provider.priceRange.start} - ${provider.priceRange.end}');
                print('Food Type: ${provider.selectedFoodType}');
                print('Restaurant Type: ${provider.selectedRestaurantType}');
              },
              child: const Text("Apply"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                foregroundColor: Theme.of(context).colorScheme.primary,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: provider.resetFilters,
              child: const Text("Reset"),
            ),
          ],
        ),
      );
    });
  }
}
