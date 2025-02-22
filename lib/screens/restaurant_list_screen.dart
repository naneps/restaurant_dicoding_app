import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/widgets/button_toggle_theme.dart';
import 'package:restaurant_dicoding_app/widgets/empty_data_widget.dart';
import 'package:restaurant_dicoding_app/widgets/error_widget.dart';
import 'package:restaurant_dicoding_app/widgets/loading_widget.dart';
import 'package:restaurant_dicoding_app/widgets/restaurant_grid_item.dart';
import 'package:restaurant_dicoding_app/widgets/search_restaurant_widget.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RestaurantProvider>().getRestaurants();
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onPanDown: (_) {
            FocusScope.of(context).unfocus();
          },
          child: Consumer<RestaurantProvider>(
            builder: (context, provider, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  await provider.getRestaurants();
                },
                child: CustomScrollView(
                  primary: true,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // const SizedBox(height: 10),
                    SliverAppBar(
                      title: const Text('Find a Restaurant'),
                      forceMaterialTransparency: true,
                      expandedHeight: 0,
                      actions: [ButtonToggleTheme()],
                    ),
                    Builder(
                      builder: (_) {
                        return SliverAppBar(
                          automaticallyImplyLeading: false,
                          snap: true,
                          floating: true,
                          pinned: true,
                          forceMaterialTransparency: true,
                          expandedHeight: provider.isSearching ? 80 : null,
                          flexibleSpace: Container(
                            color: Theme.of(context).colorScheme.surface,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SearchRestaurantWidget(),
                          ),
                        );
                      },
                    ),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: Consumer<RestaurantProvider>(
                        builder: (context, provider, child) {
                          final state = provider.state;
                          if (state is RestaurantLoadingState) {
                            return SliverFillRemaining(child: LoadingWidget());
                          } else if (state is RestaurantLoadedState) {
                            return SliverLayoutBuilder(
                              builder: (context, constraints) {
                                return SliverGrid.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            (constraints.crossAxisExtent ~/ 200)
                                                .clamp(2, 10),
                                        mainAxisExtent: 250,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                  itemCount: state.restaurants.length,
                                  itemBuilder: (context, index) {
                                    final restaurant = state.restaurants[index];
                                    return RestaurantGridItem(
                                      restaurant: restaurant,
                                    );
                                  },
                                );
                              },
                            );
                          } else if (state is RestaurantEmptyState) {
                            return const SliverFillRemaining(
                              child: EmptyDataWidget(),
                            );
                          } else if (state is RestaurantErrorState) {
                            return SliverFillRemaining(
                              child: ErrorStateWidget(),
                            );
                          } else {
                            return const SliverFillRemaining(
                              child: Center(
                                child: Text('Unexpected error occurred'),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
