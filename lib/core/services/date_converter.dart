import 'package:easy_localization/easy_localization.dart';

import '../../main.dart';

class DateConverter {
  static final _fullFormat = DateFormat('dd.MM.yyyy HH:mm:ss', 'en_US');
  static final _shortFormat = DateFormat('dd.MM.yyyy HH:mm', 'en_US');
  static final _dateOnlyFormat = DateFormat('dd.MM.yyyy', 'en_US');
  static final _dayMonthYearFormat = DateFormat('dd MMMM yyyy', 'en_US');
  static final _timeFormat = DateFormat('HH:mm', 'en_US');
  static final _amPmFormat = DateFormat('hh:mm a', 'en_US');

  static DateFormat get _dayNameDayMonthFormat => DateFormat('EEEE dd MMMM', AppContext!.locale.languageCode);

  // --------------------------[ formatToDayNameDayMonth ]-------------------------- //
  static String formatToDayNameDayMonth(DateTime dateTime) => _dayNameDayMonthFormat.format(dateTime);

  // --------------------------[ durationToTimer ]-------------------------- //
  static String durationToTimer(Duration duration) {
    final h = duration.inHours.toString().padLeft(2, '0');
    final m = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final s = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  // --------------------------[ _tryParse ]-------------------------- //
  static DateTime? _tryParse(String? date) {
    if (date == null || date.isEmpty) return null;
    return DateTime.tryParse(date.replaceFirst(' ', 'T'));
  }

  // --------------------------[ _applyFormat ]-------------------------- //
  static String? _applyFormat(String? date, DateFormat formatter) {
    final dt = _tryParse(date);
    return dt != null ? formatter.format(dt) : date;
  }

  // --------------------------[ formatToGerman ]-------------------------- //
  static String? formatToGerman(String? date) => _applyFormat(date, _fullFormat);

  // --------------------------[ formatToGermanShort ]-------------------------- //
  static String? formatToGermanShort(String? date) => _applyFormat(date, _shortFormat);

  // --------------------------[ formatToGermanDateOnly ]-------------------------- //
  static String? formatToGermanDateOnly(String? date) => _applyFormat(date, _dateOnlyFormat);

  // --------------------------[ formatToDayMonthYear ]-------------------------- //
  static String? formatToDayMonthYear(String? date) => _applyFormat(date, _dayMonthYearFormat);

  // --------------------------[ formatTime ]-------------------------- //
  static String formatTime(DateTime dateTime) => _timeFormat.format(dateTime);

  // --------------------------[ formatTimeRange ]-------------------------- //
  static String formatTimeRange(DateTime start, int intervalMinutes) {
    final end = start.add(Duration(minutes: intervalMinutes));
    return "${formatTime(start)} - ${formatTime(end)}";
  }

  // --------------------------[ formatAmPm ]-------------------------- //
  static String formatAmPm(DateTime dateTime) => _amPmFormat.format(dateTime);

  // --------------------------[ formatToApi ]-------------------------- //
  static String formatToApi(DateTime dateTime) => dateTime.toUtc().toIso8601String();
}
