import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/constants/app_constants.dart';
import 'package:restaurant_dicoding_app/constants/app_routes.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/widgets/loading_image_widget.dart';

class RestaurantGridItem extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantGridItem({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: restaurant.id!,
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surfaceContainer,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        if (restaurant.id != null) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.restaurantDetail,
                            arguments: restaurant.id,
                          );
                        } else {}
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            "$restaurantSmallImageUrl${restaurant.pictureId}",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return LoadingImageWidget();
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Material(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Theme.of(context).colorScheme.onSurface,
                          child: Icon(
                            Icons.favorite_border,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "${restaurant.name}",
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15,
                      ),
                      Text(
                        "${restaurant.rating}",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  Text(
                    "${restaurant.city}",
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              Row(
                spacing: 5,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 20),
                        fixedSize: Size(MediaQuery.of(context).size.width, 30),
                        padding: const EdgeInsets.all(0),
                      ),
                      child: const Text('View Details'),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.restaurantDetail,
                            arguments: restaurant.id);
                      },
                    ),
                  ),
                  Tooltip(
                    message: "Route",
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.all(10),
                      style: IconButton.styleFrom(
                        minimumSize: Size(30, 30),
                        fixedSize: Size(30, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(0),
                        visualDensity: VisualDensity.compact,
                      ),
                      icon: Icon(
                        Icons.drive_eta_outlined,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
