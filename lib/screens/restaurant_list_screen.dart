import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/widgets/error_widget.dart';
import 'package:restaurant_dicoding_app/widgets/restaurant_grid_item.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find a Restaurant'),
          forceMaterialTransparency: true,
        ),
        body: ChangeNotifierProvider(
          create: (_) => RestaurantProvider(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<RestaurantProvider>(
                    builder: (context, provider, child) {
                      final state = provider.state;
                      print("state: ${state.runtimeType}");
                      if (state is RestaurantLoadingState) {
                        return const Center(
                          child: Text('Loading...'),
                        );
                      } else if (state is RestaurantLoadedState) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: state.restaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant = state.restaurants[index];
                            return RestaurantGridItem(restaurant: restaurant);
                          },
                        );
                      } else if (state is RestaurantEmptyState) {
                        return const Center(
                          child: Text('No data found'),
                        );
                      } else if (state is RestaurantEmptyState) {
                        return ErrorStateWidget();
                      } else {
                        return const Center(
                          child: Text('Unexpected error occurred'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now access your provider
    Provider.of<RestaurantProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false).getRestaurants();
  }
}
