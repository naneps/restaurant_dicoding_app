import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/constants/app_constants.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/widgets/error_widget.dart';

class RestaurantDetailScreen extends StatefulWidget {
  String id;
  RestaurantDetailScreen({super.key, required this.id});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<RestaurantProvider>(
            builder: (context, provider, child) {
              if (provider.state is RestaurantLoadingState) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (provider.state is RestaurantLoadedDetailState) {
                final restaurant =
                    (provider.state as RestaurantLoadedDetailState).restaurant;
                return Column(
                  children: [
                    Hero(
                      tag: restaurant.id!,
                      child: ClipRRect(
                        child: Image.network(
                          "$restaurantLargeImageUrl${restaurant.pictureId}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (provider.state is RestaurantErrorState) {
                return ErrorStateWidget();
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now it's safe to access the Provider.
    // final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
    // print(restaurantId);
  }

  @override
  void initState() {
    super.initState();
    // Avoid using Provider in initState; move it to didChangeDependencies.
    Provider.of<RestaurantProvider>(context, listen: false)
        .getRestaurant(widget.id);
  }
}
