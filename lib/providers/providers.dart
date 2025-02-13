// lib/providers/setting_providers.dart

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:restaurant_dicoding_app/providers/filter_provider.dart';
import 'package:restaurant_dicoding_app/providers/home_provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant_detail_provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant_favorite_provider.dart';
import 'package:restaurant_dicoding_app/providers/setting_provider.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';
import 'package:restaurant_dicoding_app/services/local_notification_service.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';
import 'package:restaurant_dicoding_app/services/restaurant_favorite_service.dart';
// lib/providers/restaurant_providers.dart

class RestaurantProviders {
  static List<SingleChildWidget> get providers => [
        Provider(create: (_) => RestaurantFavoriteService()..init()),
        ChangeNotifierProvider(
            create: (context) => RestaurantProvider(
                favoriteService: context.read<RestaurantFavoriteService>())),
        ChangeNotifierProvider(
            create: (context) => RestaurantDetailProvider(
                favoriteService: context.read<RestaurantFavoriteService>())),
        ChangeNotifierProvider(
            create: (context) => RestaurantFavoriteProvider(
                context.read<RestaurantFavoriteService>())),
      ];
}

class SettingProviders {
  static List<SingleChildWidget> get providers => [
        Provider(create: (_) => LocalNotificationService()..init()),
        Provider(create: (_) => LocalStorageService()..init()),
        ChangeNotifierProvider(
          create: (context) => SettingProvider(
            localStorageService: context.read<LocalStorageService>(),
            localNotificationService: context.read<LocalNotificationService>(),
          )..init(),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ];
}

// lib/providers/theme_providers.dart

class ThemeProviders {
  static List<SingleChildWidget> get providers => [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ];
}
