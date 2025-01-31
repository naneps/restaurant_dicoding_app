import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/constants/app_constants.dart';
import 'package:restaurant_dicoding_app/models/restaurant_menu_item.model.dart';
import 'package:restaurant_dicoding_app/widgets/loading_image_widget.dart';

class MenuWidget extends StatelessWidget {
  final RestaurantMenuItem item;

  const MenuWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 5,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://via.assets.so/img.jpg?tc=blackt=${item.name}",
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      assetPlaceholderImg,
                      fit: BoxFit.cover,
                      height: 100,
                      width: double.infinity,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return LoadingImageWidget(
                      size: const Size(double.infinity, 100),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              alignment: Alignment.center,
              child: Tooltip(
                message: item.name!,
                child: Text(
                  item.name!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
