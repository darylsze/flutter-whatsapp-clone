standardizeNumber(num) => num.toString().padLeft(2, '0');

getTodayAt({int hour, int min, int sec}) {
  final targetDate =
      '2019-05-20 ${standardizeNumber(hour)}:${standardizeNumber(min)}:${standardizeNumber(sec)}';
  return DateTime.parse(targetDate);
}
