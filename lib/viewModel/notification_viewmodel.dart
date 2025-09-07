import 'package:cronometro_mobile2/viewModel/notification_service.dart';

class NotificationViewModel {
  final NotificationService _notificationService = NotificationService();

  Future initializeNotifications() async {
    await _notificationService.initialize();
  }

  /// Notificação persistente do cronômetro em execução
  Future generatePersistentNotification(String content) async {
    await _notificationService.showPersistentTimerNotification(content);
  }

  /// Notificação de volta registrada
  Future generateLapNotification(
    int lapIndex,
    String lapTime,
    String totalTime,
  ) async {
    await _notificationService.showLapNotification(
      lapIndex,
      lapTime,
      totalTime,
    );
  }

  /// Cancelar notificação persistente
  Future cancelPersistentNotification() async {
    await _notificationService.cancelPersistentNotification();
  }
}
