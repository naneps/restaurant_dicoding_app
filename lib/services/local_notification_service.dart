import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_dicoding_app/constants/app_routes.dart';
import 'package:restaurant_dicoding_app/main.dart';
import 'package:restaurant_dicoding_app/models/notification.model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final StreamController<NotificationModel> didReceiveLocalNotificationStream =
    StreamController<NotificationModel>.broadcast();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin(); // Instance lokal
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

class LocalNotificationService {
  LocalNotificationService();

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  Future<void> init() async {
    try {
      await configureLocalTimeZone();
      await _requestNotificationPermission();

      const initializationSettingsAndroid = AndroidInitializationSettings(
        'app_icon',
      );

      final initializationSettingsDarwin = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      // Inisialisasi notifikasi dengan callback saat diklik
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) {
          final payload = notificationResponse.payload;
          if (payload != null && payload.isNotEmpty) {
            print("🔔 Payload: $payload");
            final data = jsonDecode(payload);
            if (data['type'] == 'restaurant_detail') {
              MainApp.navigatorKey.currentState?.pushNamed(
                AppRoutes.restaurantDetail,
                arguments: data['id'],
              );
            }

            selectNotificationStream.add(payload);
          }
        },
      );

      print("🔔 LocalNotificationService initialized successfully");
    } catch (e) {
      print("⚠️ Error initializing notifications: $e");
    }
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    String channelId = "1",
    String channelName = "Scheduled Notification",
  }) async {
    try {
      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

      final notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: iOSPlatformChannelSpecifics,
      );

      final datetimeSchedule = _scheduleDateTime();

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        datetimeSchedule,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }

  Future<void> showBigPictureNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    required String imageUrl, // URL gambar restoran
    String channelId = 'big_picture_channel_id',
    String channelName = 'Big Picture Channel',
  }) async {
    final String? filePath =
        await _downloadAndSaveFile(imageUrl, 'big_picture.jpg');

    if (filePath == null) return; // Jika gagal download, skip notifikasi

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(
        filePath,
      ),
      largeIcon: FilePathAndroidBitmap(filePath),
      contentTitle: title,
      htmlFormatContent: true,
      summaryText: body,
      htmlFormatTitle: true,
      htmlFormatContentTitle: true,
      htmlFormatSummaryText: true,
      hideExpandedLargeIcon: true,
    );

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
      ticker: 'ticker',
    );

    await showNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
      androidDetails: androidDetails,
    );
  }

  Future<void> showBigTextNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    final BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
      body,
      htmlFormatContent: true,
      htmlFormatTitle: true,
      htmlFormatSummaryText: true,
      htmlFormatBigText: true,
      summaryText: body,
    );

    final androidDetails = AndroidNotificationDetails(
      'big_text_channel_id',
      'Big Text Channel',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigTextStyleInformation,
      ticker: 'ticker',
    );

    await showNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
      androidDetails: androidDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String channelId = "1",
    String channelName = "Default",
    AndroidNotificationDetails? androidDetails,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      payload: payload,
      NotificationDetails(
        android: androidDetails ??
            AndroidNotificationDetails(
              channelId,
              channelName,
              importance: Importance.max,
              priority: Priority.high,
            ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  /// **Method untuk download gambar dari URL dan simpan ke file lokal**
  Future<String?> _downloadAndSaveFile(String url, String filename) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Directory directory = await getApplicationDocumentsDirectory();
        final String filePath = '${directory.path}/$filename';
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
    return null;
  }

  _isAndroidPermissionGranted() async {
    final status = await Permission.storage.status;
    return status.isGranted;
  }

  Future<bool> _requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<void> _requestNotificationPermission() async {
    await _requestPermissions();
    await _requestExactAlarmsPermission();
  }

  Future<bool?> _requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final requestNotificationsPermission =
          await androidImplementation?.requestNotificationsPermission();
      final notificationEnabled = await _isAndroidPermissionGranted();
      final requestAlarmEnabled = await _requestExactAlarmsPermission();
      return (requestNotificationsPermission ?? false) &&
          notificationEnabled &&
          requestAlarmEnabled;
    } else {
      return false;
    }
    return null;
  }

  tz.TZDateTime _scheduleDateTime() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
