import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //
import 'package:restaurant_dicoding_app/constants/app_routes.dart';
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
import 'package:restaurant_dicoding_app/themes/theme.dart';
import 'package:restaurant_dicoding_app/themes/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService().init();
  await favoriteService.init();
  await LocalNotificationService().init();
  runApp(const MainApp());
}

final favoriteService = RestaurantFavoriteService();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiProvider(
      providers: [
        Provider.value(value: favoriteService),
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(
            favoriteService: favoriteService,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            favoriteService: favoriteService,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantFavoriteProvider(favoriteService)..getFavorites(),
        ),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dicoding Restaurant',
            theme: theme.light(),
            themeMode: provider.themeMode,
            onGenerateInitialRoutes: (initialRoute) {
              return [
                AppRoutes.generateRoute(RouteSettings(name: initialRoute)),
              ];
            },
            darkTheme: theme.dark(),
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
