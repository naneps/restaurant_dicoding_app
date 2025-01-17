import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/constants/app_constants.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/models/restaurant_item.model.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/widgets/error_widget.dart';
import 'package:restaurant_dicoding_app/widgets/loading_image_widget.dart';
import 'package:restaurant_dicoding_app/widgets/loading_widget.dart';

part '../widgets/detail_overview_section.dart';
part '../widgets/restaurant_menu_section.dart';
part '../widgets/restaurant_review_section.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (BuildContext context) {
        return RestaurantProvider()..getRestaurant(widget.id);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          forceMaterialTransparency: true,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.share_outlined),
              onPressed: () {},
              iconSize: 20.0,
            )
          ],
        ),
        body: SafeArea(
          child: Hero(
            tag: widget.id,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Consumer<RestaurantProvider>(
                builder: (context, provider, child) {
                  if (provider.state is RestaurantLoadingState) {
                    return LoadingWidget();
                  } else if (provider.state is RestaurantLoadedDetailState) {
                    final restaurant =
                        (provider.state as RestaurantLoadedDetailState)
                            .restaurant;
                    return _buildContent(restaurant, context);
                  } else if (provider.state is RestaurantErrorState) {
                    return ErrorStateWidget();
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(RestaurantModel restaurant, BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: ListView(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "$restaurantLargeImageUrl${restaurant.pictureId}",
              fit: BoxFit.fill,
              height: 250,
              width: double.infinity,
              cacheHeight: 250,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return LoadingImageWidget(
                  size: const Size(double.infinity, 250),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            spacing: 5,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      restaurant.city!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20.0,
                  ),
                  Text(
                    "${restaurant.rating}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.red,
                ),
                iconSize: 20.0,
                onPressed: () {},
              )
            ],
          ),
          const Divider(),
          TabBar(
            tabs: [
              Tab(text: "Overview"),
              Tab(text: "Menu"),
              Tab(text: "Review"),
            ],
            padding: const EdgeInsets.all(0),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              minHeight: 100,
            ),
            child: TabBarView(
              children: [
                DetailOverViewSection(restaurant: restaurant),
                RestaurantMenuSection(restaurant: restaurant),
                RestaurantReviewSection(restaurant: restaurant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
