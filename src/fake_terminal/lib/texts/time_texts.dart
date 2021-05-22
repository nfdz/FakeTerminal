class TimeTexts {
  static const List<String> _kMonthsOfTheYear = [
    "jan",
    "feb",
    "mar",
    "apr",
    "may",
    "jun",
    "jul",
    "aug",
    "sep​",
    "oct",
    "nov",
    "dec",
  ];

  static const List<String> _kDaysOfTheWeek = [
    "mon",
    "tue",
    "wed",
    "thu",
    "fri",
    "sat",
    "sun",
  ];

  static String lastLoginMessage(int timestampMillis) {
    final time = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
    final day = _kDaysOfTheWeek[time.weekday - 1];
    final month = _kMonthsOfTheYear[time.month - 1];
    return "Last login: $day $month ${time.day} ${time.hour}:${time.minute}:${time.second} on ttys000";
  }

  static String getCurrentMonthText() => _kMonthsOfTheYear[DateTime.now().month - 1];
}
