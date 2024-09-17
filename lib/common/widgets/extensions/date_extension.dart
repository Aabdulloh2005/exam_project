extension DateTimeX on DateTime {
  String format() {
    if (month < 10) {
      return "$day-0$month-$year";
    }
    return "$day-$month-$year";
  }
}
