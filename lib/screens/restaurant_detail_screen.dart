import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/constants/app_constants.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/models/restaurant_item.model.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/widgets/error_widget.dart';
import 'package:restaurant_dicoding_app/widgets/field_review.dart';
import 'package:restaurant_dicoding_app/widgets/loading_image_widget.dart';
import 'package:restaurant_dicoding_app/widgets/loading_widget.dart';
import 'package:restaurant_dicoding_app/widgets/menu_widget.dart';

part '../widgets/detail_overview_section.dart';
part '../widgets/restaurant_menu_section.dart';
part '../widgets/restaurant_review_section.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider()..getRestaurant(id),
      child: Hero(
        tag: id,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Detail '),
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
          body:
              Consumer<RestaurantProvider>(builder: (context, provider, child) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                await provider.getRestaurant(id);
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Consumer<RestaurantProvider>(
                    builder: (context, provider, child) {
                      if (provider.state is RestaurantLoadingState) {
                        return LoadingWidget();
                      } else if (provider.state
                          is RestaurantLoadedDetailState) {
                        final restaurant =
                            (provider.state as RestaurantLoadedDetailState)
                                .restaurant;
                        return _buildContent(restaurant, context);
                      } else {
                        return ErrorStateWidget();
                      }
                    },
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildContent(RestaurantModel restaurant, BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _RestaurantSmallScreen(
            restaurant: restaurant,
            constraints: constraints,
          );
        } else {
          return _RestaurantLargeScreen(
            restaurant: restaurant,
            constraints: constraints,
          );
        }
      }),
    );
  }
}

class _RestaurantImage extends StatelessWidget {
  final RestaurantModel restaurant;
  final BoxConstraints constraints;
  const _RestaurantImage({
    required this.restaurant,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: SizedBox.shrink(),
      expandedHeight: constraints.maxHeight * 0.4,
      pinned: false,
      stretch: true,
      forceMaterialTransparency: true,
      flexibleSpace: Container(
        padding: const EdgeInsets.all(10),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "$restaurantLargeImageUrl${restaurant.pictureId}",
            fit: BoxFit.cover,
            height: constraints.maxHeight * 0.4,
            width: double.infinity,
            cacheHeight: 250,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                assetPlaceholderImg,
                fit: BoxFit.cover,
                height: constraints.maxHeight * 0.4,
                width: double.infinity,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return LoadingImageWidget(
                size: Size(double.infinity, constraints.maxHeight * 0.4),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RestaurantInformation extends StatelessWidget {
  final BoxConstraints constraints;
  final RestaurantModel restaurant;
  const _RestaurantInformation({
    required this.restaurant,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: constraints.maxHeight <= 400 ? false : true,
      stretch: true,
      leading: SizedBox.shrink(),
      elevation: 0,
      collapsedHeight: 100.0,
      forceMaterialTransparency: true,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 5,
          children: [
            Expanded(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name!,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 5,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.red,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          '${restaurant.address!}, ${restaurant.city!}',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
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
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              ),
              icon: const Icon(
                Icons.favorite_outline,
                color: Colors.red,
              ),
              iconSize: 20.0,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class _RestaurantLargeScreen extends StatelessWidget {
  final RestaurantModel restaurant;
  final BoxConstraints constraints;
  final _tabs = ["Menu", "Review"];
  _RestaurantLargeScreen({
    required this.restaurant,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      spacing: 10,
      children: [
        Expanded(
          flex: 2,
          child: CustomScrollView(
            slivers: [
              _RestaurantImage(
                restaurant: restaurant,
                constraints: constraints,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              _RestaurantInformation(
                restaurant: restaurant,
                constraints: constraints,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverFillRemaining(
                child: DetailOverViewSection(restaurant: restaurant),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: DefaultTabController(
            length: _tabs.length,
            child: CustomScrollView(
              slivers: [
                _TabbarSection(tabs: _tabs),
                SliverFillRemaining(
                  child: TabBarView(
                    children: [
                      RestaurantMenuSection(restaurant: restaurant),
                      RestaurantReviewSection(restaurant: restaurant),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RestaurantSmallScreen extends StatelessWidget {
  final RestaurantModel restaurant;
  final BoxConstraints constraints;
  final _tabs = ["Overview", "Menu", "Review"];
  _RestaurantSmallScreen({
    required this.restaurant,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: CustomScrollView(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        slivers: [
          _RestaurantImage(
            restaurant: restaurant,
            constraints: constraints,
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          _RestaurantInformation(
            restaurant: restaurant,
            constraints: constraints,
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          _TabbarSection(tabs: _tabs),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverFillRemaining(
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

class _TabbarSection extends StatelessWidget {
  final List<String> tabs;
  const _TabbarSection({required this.tabs});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      forceMaterialTransparency: true,
      leading: SizedBox.shrink(),
      // backgroundColor: Theme.of(context).colorScheme.primary,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: TabBar(
          tabs: [...tabs.map((e) => Tab(text: e))],
          padding: const EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}
