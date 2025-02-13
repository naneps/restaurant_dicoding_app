import 'dart:convert';
import 'dart:math';

import 'package:restaurant_dicoding_app/constants/app_constants.dart';
import 'package:restaurant_dicoding_app/repositories/restaurant_repository.dart';
import 'package:workmanager/workmanager.dart';

import 'local_notification_service.dart';

const fetchBackgroundTask = "fetch_restaurant_notification";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == fetchBackgroundTask) {
      final repository = RestaurantRepository();
      final restaurants = await repository.getRestaurants();

      if (restaurants != null && restaurants.isNotEmpty) {
        final randomRestaurant =
            restaurants[Random().nextInt(restaurants.length)];

        final notificationService = LocalNotificationService();
        await notificationService.init();
        await notificationService.showBigPictureNotification(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          title: "Recommended Restaurant: <b>${randomRestaurant.name}</b>",
          body: randomRestaurant.description ?? '',
          payload: jsonEncode(
            {'type': 'restaurant_detail', 'id': randomRestaurant.id},
          ),
          imageUrl:
              '$restaurantSmallImageUrl${randomRestaurant.pictureId!}', // Tambahkan gambar restoran
          channelId: "1",
          channelName: "Background Notification",
        );
      }
    }
    return Future.value(true);
  });
}

class WorkManagerService {
  static void init() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  static void registerDailyTask() {
    Workmanager().registerPeriodicTask(
      "fetch_restaurant_notification",
      fetchBackgroundTask,
      frequency: const Duration(minutes: 15),
      initialDelay: const Duration(seconds: 3),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
  }
}
