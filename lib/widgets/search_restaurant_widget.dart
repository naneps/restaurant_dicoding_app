import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/widgets/filter_widget.dart';

class SearchRestaurantWidget extends StatelessWidget {
  const SearchRestaurantWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, child) {
        return Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                Expanded(
                  child: TextField(
                    controller: provider.searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      hintText: 'Find your favorite restaurant',
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Theme.of(context).colorScheme.surfaceContainer,
                      suffix: InkWell(
                        child: Icon(Icons.clear),
                        onTap: () {
                          provider.searchController.clear();
                          provider.searchRestaurants('');
                        },
                      ),
                    ),
                    onChanged: (value) {
                      provider.searchRestaurants(value);
                    },
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    minimumSize: const Size(40, 40),
                  ),
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        return FilterWidget();
                      },
                      backgroundColor: Colors.transparent,
                    );
                  },
                  icon: Icon(
                    Icons.filter_list,
                    size: 20,
                  ),
                )
              ],
            ),
            if (provider.isSearching) ...[
              if (provider.state is RestaurantLoadedState) ...[
                Text.rich(
                  TextSpan(
                    text: 'We found ',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text: (provider.state as RestaurantLoadedState)
                            .restaurants
                            .length
                            .toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' results for "'),
                      TextSpan(
                        text: provider.searchController.text,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '"'),
                    ],
                  ),
                )
              ] else if (provider.state is RestaurantEmptyState) ...[
                Text.rich(
                  TextSpan(
                    text: 'We found no results for "',
                    style: TextStyle(fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text: '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '"${provider.searchController.text}"'),
                    ],
                  ),
                )
              ]
            ],
          ],
        );
      },
    );
  }
}
