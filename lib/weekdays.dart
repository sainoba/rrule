import 'package:rrule/exceptions.dart';

enum WeekDay {
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY,
  SUNDAY,
}

class WeekDayItem {
  final WeekDay weekDay;
  final int ordwk;
  WeekDayItem(this.weekDay, this.ordwk);

  bool operator ==(o) =>
      o is WeekDayItem && o.weekDay == weekDay && o.ordwk == ordwk;
  int get hashCode => "${weekDay.hashCode}-${ordwk.hashCode}".hashCode;
}

WeekDay stringToWeekDay(String weekDayString) {
  switch (weekDayString) {
    case "MO":
      return WeekDay.MONDAY;
    case "TU":
      return WeekDay.TUESDAY;
    case "WE":
      return WeekDay.WEDNESDAY;
    case "TH":
      return WeekDay.THURSDAY;
    case "FR":
      return WeekDay.FRIDAY;
    case "SA":
      return WeekDay.SATURDAY;
    case "SU":
      return WeekDay.SUNDAY;
    default:
      throw RRuleException("Invalid value: $weekDayString");
  }
}
