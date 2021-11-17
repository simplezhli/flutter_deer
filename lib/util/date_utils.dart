library utils;

import 'package:intl/intl.dart';

/// date_utils（version：0.1.0+2） : https://github.com/apptreesoftware/date_utils
/// @Author: aleksanderwozniak
/// @GitHub: https://github.com/aleksanderwozniak/table_calendar
/// @Description: Date Util.
class DateUtils {
  static final DateFormat _monthFormat = DateFormat('MMMM yyyy');
  static final DateFormat _dayFormat = DateFormat('dd');
  static final DateFormat _firstDayFormat = DateFormat('MMM dd');
  static final DateFormat _fullDayFormat = DateFormat('EEE MMM dd, yyyy');
  static final DateFormat _apiDayFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _apiDayFormat2 = DateFormat('yy.MM.dd');

  static String formatMonth(DateTime d) => _monthFormat.format(d);
  static String formatDay(DateTime d) => _dayFormat.format(d);
  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);
  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);
  static String apiDayFormat2(DateTime d) => _apiDayFormat2.format(d);


  static const List<String> weekdays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  /// 周一开始
  static List<DateTime> daysInMonth(DateTime month) {
    final first = firstDayOfMonth(month);
    final daysBefore = first.weekday - 1;
    var firstToDisplay = first.subtract(Duration(days: daysBefore));

    if (firstToDisplay.hour == 23) {
      firstToDisplay = firstToDisplay.add(const Duration(hours: 1));
    }

    var last = lastDayOfMonth(month);

    if (last.hour == 23) {
      last = last.add(const Duration(hours: 1));
    }

    var daysAfter = 7 - last.weekday;

    daysAfter++;

    var lastToDisplay = last.add(Duration(days: daysAfter));

    if (lastToDisplay.hour == 1) {
      lastToDisplay = lastToDisplay.subtract(const Duration(hours: 1));
    }

    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  static DateTime firstDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    final decreaseNum = day.weekday % 7;
    return day.subtract(Duration(days: decreaseNum));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    final increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    final beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(const Duration(days: 1));
      final timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    final diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    final min = a.isBefore(b) ? a : b;
    final max = a.isBefore(b) ? b : a;
    final result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  static DateTime previousWeek(DateTime w) {
    return w.subtract(const Duration(days: 7));
  }

  static DateTime nextWeek(DateTime w) {
    return w.add(const Duration(days: 7));
  }

  static String previousWeekToString(DateTime w) {
    return apiDayFormat2(w.subtract(const Duration(days: 6)));
  }

  static DateTime nextDay(DateTime w) {
    return w.add(const Duration(days: 1));
  }

  static List<DateTime> daysInWeek(DateTime week) {
    final first = _firstDayOfWeek(week);
    final last = _lastDayOfWeek(week);

    final days = daysInRange(first, last);
    return days.map((day) => DateTime(day.year, day.month, day.day)).toList();
  }

  static DateTime _firstDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final decreaseNum = day.weekday - 1;
    return day.subtract(Duration(days: decreaseNum));
  }

  static DateTime _lastDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final increaseNum = day.weekday - 1;
    return day.add(Duration(days: 7 - increaseNum));
  }

  static bool isExtraDay(DateTime day, DateTime now) {
    return _isExtraDayBefore(day, now) || _isExtraDayAfter(day, now);
  }

  static bool _isExtraDayBefore(DateTime day, DateTime now) {
    return day.month < now.month;
  }

  static bool _isExtraDayAfter(DateTime day, DateTime now) {
    return day.month > now.month;
  }
}
