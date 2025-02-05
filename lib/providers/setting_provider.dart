import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/constants/key_storage.dart';
import 'package:restaurant_dicoding_app/services/local_notification_service.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';

class SettingProvider extends ChangeNotifier {
  final LocalNotificationService _localNotificationService =
      LocalNotificationService();
  bool isNotificationEnabled = false;
  final LocalStorageService _localStorageService = LocalStorageService();

  void enableNotification(bool value) async {
    print(value);
    await _localStorageService.saveBool(
      KeyStorage.notificationReminder.name,
      value,
    );
    if (value) {
      await _localNotificationService.showNotification(
          id: 1, title: "test", body: "tes", payload: "tes");
      isNotificationEnabled = true;
    } else {
      //   _localNotificationService.cancelNotification(
      //     id: 1,
      //   );
      isNotificationEnabled = false;
    }
    notifyListeners();
  }

  Future<void> init() async {
    isNotificationEnabled =
        _localStorageService.getBool(KeyStorage.notificationReminder.name) ??
            false;
    notifyListeners();
  }
}
