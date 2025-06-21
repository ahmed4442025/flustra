extension DurationEx on Duration? {
  // convert duration to time format   => EX: 00:05:21
  String toStringFormat({bool showHours = false}) {
    Duration duration = this ?? Duration.zero;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0 || showHours) hours, minutes, seconds].join(':');
  }
}
