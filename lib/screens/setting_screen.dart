import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/setting_provider.dart';
import 'package:restaurant_dicoding_app/widgets/switch_button_theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        forceMaterialTransparency: true,
      ),
      body: Consumer<SettingProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.palette,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              title: Text(
                'Theme',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: SizedBox(
                width: 200,
                child: SwitchButtonTheme(),
              ),
            ),
            ListTile(
              title: Text(
                'Notification Reminder',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                'Enable Notification For Reminder Launch',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              leading: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              trailing: Switch(
                value: provider.isNotificationEnabled,
                onChanged: (value) {
                  provider.enableNotification(value);
                },
              ),
            ),
            OutlinedButton(
              onPressed: () {
                provider.showNotification();
              },
              child: const Text(
                'Test Notification',
              ),
            ),
            // Menampilkan daftar notifikasi yang dijadwalkan
            FutureBuilder<List<PendingNotificationRequest>>(
              future: provider.getScheduledNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("No scheduled notifications.");
                }

                final notifications = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return ListTile(
                      title: Text(notification.title ?? 'No Title'),
                      subtitle: Text(notification.body ?? 'No Body'),
                      leading: const Icon(Icons.notifications),
                      trailing: Text(notification.id.toString()),
                    );
                  },
                );
              },
            )
          ],
        );
      }),
    );
  }
}
