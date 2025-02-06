import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_dicoding_app/constants/key_storage.dart';
import 'package:restaurant_dicoding_app/services/local_notification_service.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';

class SettingProvider extends ChangeNotifier {
  final LocalNotificationService _localNotificationService =
      LocalNotificationService();
  bool isNotificationEnabled = false;
  final LocalStorageService _localStorageService = LocalStorageService();

  SettingProvider() {
    init();
  }

  void enableNotification(bool value) async {
    await _localStorageService.saveBool(
      KeyStorage.notificationReminder.name,
      value,
    );
    if (value) {
      await _localNotificationService.scheduleDailyNotification(
        id: 1,
        title: "🍽️ Lunch Reminder!",
        body: "⏰ Take a break and enjoy your lunch. Your energy matters! 😋",
      );
      isNotificationEnabled = true;
    } else {
      await _localNotificationService.cancelNotification(1);
      isNotificationEnabled = false;
    }
    notifyListeners();
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
    return await _localNotificationService.getScheduledNotifications();
  }

  Future<void> init() async {
    isNotificationEnabled =
        _localStorageService.getBool(KeyStorage.notificationReminder.name) ??
            false;
    notifyListeners();
  }

  void showNotification() async {
    await _localNotificationService.showNotification(
      id: Random().nextInt(999),
      title: "Test Notification",
      body: "This is a test notification",
    );
  }
}
