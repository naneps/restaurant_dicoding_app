import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //
import 'package:restaurant_dicoding_app/constants/app_routes.dart';
import 'package:restaurant_dicoding_app/providers/providers.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';
import 'package:restaurant_dicoding_app/services/work_manager_service.dart';
import 'package:restaurant_dicoding_app/themes/theme.dart';
import 'package:restaurant_dicoding_app/themes/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WorkManagerService.init();
  WorkManagerService.registerDailyTask();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiProvider(
      providers: [
        ...RestaurantProviders.providers,
        ...SettingProviders.providers,
        ...ThemeProviders.providers,
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
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
