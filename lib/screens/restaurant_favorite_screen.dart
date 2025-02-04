import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant_favorite_provider.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/widgets/empty_data_widget.dart';
import 'package:restaurant_dicoding_app/widgets/error_widget.dart';
import 'package:restaurant_dicoding_app/widgets/loading_widget.dart';
import 'package:restaurant_dicoding_app/widgets/restaurant_grid_item.dart';

class RestaurantFavoriteScreen extends StatelessWidget {
  const RestaurantFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onPanDown: (_) {
            FocusScope.of(context).unfocus();
          },
          child: Consumer<RestaurantFavoriteProvider>(
            builder: (context, provider, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  provider.getFavorites();
                },
                child: CustomScrollView(
                  primary: true,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Sliver AppBar untuk judul
                    SliverAppBar(
                      title: const Text('Favorite Restaurants'),
                      forceMaterialTransparency: true,
                      expandedHeight: 0,
                    ),
                    // Spacer kecil
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 10),
                    ),
                    // Sliver Grid untuk menampilkan daftar restoran favorit
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: Consumer<RestaurantFavoriteProvider>(
                        builder: (context, provider, child) {
                          final state = provider.state;
                          if (state is RestaurantLoadingState) {
                            return const SliverFillRemaining(
                              child: LoadingWidget(),
                            );
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
                                      showRemoveButton: true,
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
                            return const SliverFillRemaining(
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
