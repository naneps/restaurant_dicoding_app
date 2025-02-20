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
      body: Consumer<SettingProvider>(
        builder: (context, provider, child) {
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
                trailing: SizedBox(width: 200, child: SwitchButtonTheme()),
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
                onTap: () {
                  showPendingNotification(context);
                },
              ),
              //   OutlinedButton(
              //       onPressed: () {
              //         provider.showBigPictureNotification();
              //       },
              //       child: Text('Logout'))
            ],
          );
        },
      ),
    );
  }

  void showPendingNotification(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Pending NOtification'),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            elevation: 0,
            contentPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            titleTextStyle: Theme.of(context).textTheme.titleSmall,
            content: SizedBox(
              width: 350,
              height: 200,
              child: FutureBuilder(
                future:
                    context.read<SettingProvider>().getScheduledNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No Notification Scheduled'),
                    );
                  }
                  final data = snapshot.data!;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index].title ?? 'No Title'),
                        subtitle: Text(data[index].body ?? 'No Body'),
                      );
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
