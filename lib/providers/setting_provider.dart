import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_dicoding_app/constants/key_storage.dart';
import 'package:restaurant_dicoding_app/services/local_notification_service.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';

class SettingProvider extends ChangeNotifier {
  LocalNotificationService localNotificationService;

  bool isNotificationEnabled = false;
  LocalStorageService localStorageService;

  SettingProvider({
    required this.localNotificationService,
    required this.localStorageService,
  });

  void enableNotification(bool value) async {
    await localStorageService.saveBool(
      KeyStorage.notificationReminder.name,
      value,
    );
    if (value) {
      await localNotificationService.scheduleDailyNotification(
        id: 1,
        title: "🍽️ Lunch Reminder!",
        body: "⏰ Take a break and enjoy your lunch. Your energy matters! 😋",
      );
      isNotificationEnabled = true;
    } else {
      await localNotificationService.cancelNotification(1);
      isNotificationEnabled = false;
    }
    notifyListeners();
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
    return await localNotificationService.getScheduledNotifications();
  }

  Future<void> init() async {
    isNotificationEnabled =
        localStorageService.getBool(KeyStorage.notificationReminder.name) ??
            false;
    notifyListeners();
  }

  void showBigPictureNotification() async {
    await localNotificationService.showBigPictureNotification(
      id: Random().nextInt(999),
      title: "Test Notification",
      body: "This is a test notification",
      imageUrl: 'https://picsum.photos/200/300',
      payload: jsonEncode({'type': 'test'}),
    );
  }

  void showNotification() async {
    await localNotificationService.showNotification(
      id: Random().nextInt(999),
      title: "Test Notification",
      body: "This is a test notification",
    );
  }
}
