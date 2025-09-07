import 'dart:async';
import 'package:flutter/foundation.dart';
import '../model/timer_lap.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../viewModel/notification_service.dart';

class TimerViewModel extends ChangeNotifier {
  Duration _elapsed = Duration.zero;
  Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;

  final List<Lap> _laps = [];
  Duration _lastLapElapsed = Duration.zero;
  final NotificationService _notificationService = NotificationService();

  TimerViewModel() {
    _notificationService.initialize();
  }
  String get formattedElapsed => _formatDuration(_elapsed);
  bool get isRunning => _stopwatch.isRunning;
  List<Lap> get laps => List.unmodifiable(_laps.reversed);

  void _startTicker() {
    _ticker ??= Timer.periodic(const Duration(milliseconds: 100), (_) {
      _elapsed = _stopwatch.elapsed;
      notifyListeners();
      if (_stopwatch.isRunning) {
        _notificationService.showPersistentTimerNotification(formattedElapsed);
      }
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _startTicker();
      notifyListeners();
      _notificationService.showPersistentTimerNotification(formattedElapsed);
    }
  }

  void pause() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _stopTicker();
      notifyListeners();
      _notificationService.cancelPersistentNotification();

      Timer(const Duration(seconds: 10), () {
        if (!_stopwatch.isRunning) {
          _notificationService.showPausedReminderNotification();
        }
      });
    }
  }

  void reset() {
    _stopwatch.reset();
    _elapsed = Duration.zero;
    _laps.clear();
    _lastLapElapsed = Duration.zero;
    _stopTicker();
    notifyListeners();

    _notificationService.cancelPersistentNotification();
  }

  void lap() {
    final current = _stopwatch.elapsed;
    final lapTime = current - _lastLapElapsed;
    _lastLapElapsed = current;
    final lap = Lap(
      index: _laps.length + 1,
      lapTime: lapTime,
      totalTime: current,
    );
    _laps.add(lap);
    notifyListeners();

    _notificationService.showLapNotification(
      lap.index,
      _formatDuration(lap.lapTime),
      _formatDuration(lap.totalTime),
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final centi = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(
      2,
      '0',
    );
    if (hours > 0) {
      return '$hours:$minutes:$seconds.$centi';
    }
    return '$minutes:$seconds.$centi';
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
