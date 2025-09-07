import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(settings);
  }

  Future<void> showPersistentTimerNotification(String content) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'timer_channel',
          'Timer',
          channelDescription: 'Notificações do cronômetro em execução',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Cronômetro em execução',
      content,
      details,
    );
  }

  Future<void> showLapNotification(
    int lapIndex,
    String lapTime,
    String totalTime,
  ) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'lap_channel',
          'Voltas',
          channelDescription: 'Notificações de voltas registradas',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      lapIndex,
      'Volta $lapIndex',
      'Tempo da volta: $lapTime | Total: $totalTime',
      details,
    );
  }

  Future<void> showPausedReminderNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'reminder_channel',
          'Lembrete',
          channelDescription: 'Lembrete para continuar cronômetro pausado',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      9999,
      'Hey!',
      'Você deixou o cronômetro pausado, vamos continuar?',
      details,
    );
  }

  Future<void> cancelPersistentNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(0);
  }
}
