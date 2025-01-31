import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant_favorite_provider.dart';
import 'package:restaurant_dicoding_app/providers/states/restaurant_state.dart';
import 'package:restaurant_dicoding_app/widgets/error_widget.dart';

class RestaurantFavoriteScreen extends StatefulWidget {
  const RestaurantFavoriteScreen({super.key});

  @override
  State<RestaurantFavoriteScreen> createState() =>
      _RestaurantFavoriteScreenState();
}

class _RestaurantFavoriteScreenState extends State<RestaurantFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantFavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.state is RestaurantLoadingState) {
            return const Center(child: Text("LOADING..."));
          } else if (provider.state is RestaurantLoadedState) {
            final restaurants =
                (provider.state as RestaurantLoadedState).restaurants;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return ListTile(
                  title: Text(restaurant.name ?? 'No Name'),
                  subtitle: Text(restaurant.city ?? 'No City'),
                );
              },
            );
          } else if (provider.state is RestaurantEmptyState) {
            return const Center(child: Text("Empty"));
          } else if (provider.state is RestaurantErrorState) {
            return ErrorStateWidget();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Panggil getFavorites sekali saja saat screen pertama kali dibuka
    context.read<RestaurantFavoriteProvider>().getFavorites();
  }
}
