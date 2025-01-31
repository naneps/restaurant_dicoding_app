import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/home_provider.dart';
import 'package:restaurant_dicoding_app/screens/restaurant_favorite_screen.dart';
import 'package:restaurant_dicoding_app/screens/restaurant_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: AnimatedBuilder(
          builder: (context, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                      parent: animation, curve: Curves.easeInOut)),
                  child: child,
                );
              },
              child: provider.activeIndex == 0
                  ? const RestaurantListScreen(
                      key: ValueKey('RestaurantListScreen'),
                    )
                  : const RestaurantFavoriteScreen(
                      key: ValueKey('RestaurantFavoriteScreen'),
                    ),
            );
          },
          animation: provider,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.activeIndex,
          backgroundColor: Colors.transparent,
          onTap: (index) => provider.setActiveIndex(index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.dashboard),
              icon: Icon(Icons.dashboard_outlined),
              label: 'Explorer',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_border),
              label: 'Favorite',
            )
          ],
        ),
      );
    });
  }
}
