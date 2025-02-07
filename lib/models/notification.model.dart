class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String payload;
  NotificationModel({
    required this.title,
    required this.body,
    required this.payload,
    required this.id,
  });
}
