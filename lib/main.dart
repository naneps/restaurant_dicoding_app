import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //
import 'package:restaurant_dicoding_app/constants/app_routes.dart';
import 'package:restaurant_dicoding_app/providers/filter_provider.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';
import 'package:restaurant_dicoding_app/themes/theme.dart';
import 'package:restaurant_dicoding_app/themes/util.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
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
