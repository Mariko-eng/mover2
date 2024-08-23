import 'package:intl/intl.dart';

final Map months = {
  '1': 'Jan',
  '2': 'Feb',
  '3': 'Mar',
  '4': 'Apr',
  '5': 'May',
  '6': 'Jun',
  '7': 'Jul',
  '8': 'Aug',
  '9': 'Sept',
  '10': 'Oct',
  '11': 'Nov',
  '12': 'Dec',
};

String dateToString(DateTime dateTime) {
  final year = dateTime.year;
  final month = months[dateTime.month.toString()];
  final date = dateTime.day <= 9 ? '0' + dateTime.day.toString() : dateTime.day;
  final hour = dateTime.hour;
  final minutes = dateTime.minute;

  return '$date $month, $year at $hour:$minutes';
}

String dateToStringNew(DateTime dateTime) {
  final year = dateTime.year;
  final month = months[dateTime.month.toString()];
  final date = dateTime.day <= 9 ? '0' + dateTime.day.toString() : dateTime.day;
  final hour = dateTime.hour;
  final minutes = dateTime.minute;

  return '$date $month, $year';
}

String dateToTime(DateTime dateTime) {
  final hour =
  dateTime.hour <= 9 ? '0' + dateTime.hour.toString() : dateTime.hour;
  final min =
  dateTime.minute <= 9 ? '0' + dateTime.minute.toString() : dateTime.minute;

  return '$hour:$min';
}

String formatNumber(int amount) {
  final formatter = NumberFormat('#,###');
  return formatter.format(amount);
}
