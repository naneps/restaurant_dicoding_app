import 'package:flutter/material.dart';
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
            SwitchListTile(
              value: context.watch<SettingProvider>().isNotificationEnabled,
              onChanged: (value) {
                provider.enableNotification(value);
              },
              title: Text(
                'Notification Reminder',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                'Enable Notification For Reminder Launch',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              secondary: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            )
          ],
        );
      }),
    );
  }
}
