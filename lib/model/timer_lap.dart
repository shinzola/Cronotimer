class Lap {
  final int index; // 1-based
  final Duration lapTime; // tempo da volta
  final Duration totalTime; // tempo total até essa volta

  Lap({required this.index, required this.lapTime, required this.totalTime});
}
