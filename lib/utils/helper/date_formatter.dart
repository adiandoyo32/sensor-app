import 'package:intl/intl.dart';

class DateFormatter {
  static String getVerboseDateTime(DateTime dateTime) {
    String shortTimeString = DateFormat('jm').format(dateTime);
    DateTime now = DateTime.now();
    DateTime justNow = DateTime.now().subtract(Duration(minutes: 1));
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just now';
    }

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return shortTimeString;
    }

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == yesterday.month &&
        localDateTime.year == yesterday.year) {
      return 'Yesterday, $shortTimeString';
    }

    if (now.difference(localDateTime).inDays < 6) {
      String weekDay = DateFormat('EEEE').format(localDateTime);
      return '$weekDay, $shortTimeString';
    }

    return '${DateFormat('MMM dd, yyyy').format(localDateTime)}, $shortTimeString';
  }
}
