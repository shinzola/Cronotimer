class TimerModel {
  final int seconds;

  TimerModel(this.seconds);

  String get formattedTime {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}
