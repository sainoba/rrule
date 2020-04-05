import 'package:rrule/exceptions.dart';
import 'package:rrule/weekdays.dart';
import 'package:rrule/frequencies.dart';
import 'package:rrule/parsers/parsers.dart';

/// RRule
class RRule {
  final Frequency freq;
  final DateTime until;
  final int count;
  final int interval;
  final WeekDay wkst;
  final List<WeekDay> byDay;
  final List<int> byMonth;
  final List<int> bySetPos;
  final List<int> byMonthDay;
  final List<int> byYearDay;
  final List<int> byWeekNo;
  final List<int> byHour;
  final List<int> byMinute;
  final List<int> bySecond;
  final List<int> dtStart;
  RRule({
    this.freq,
    this.until,
    this.count,
    this.interval,
    this.wkst,
    this.byDay,
    this.byMonth,
    this.bySetPos,
    this.byMonthDay,
    this.byYearDay,
    this.byWeekNo,
    this.byHour,
    this.byMinute,
    this.bySecond,
    this.dtStart,
  });
  static RRule fromString(String rruleString) {
    const rrulePrefix = "RRULE:";
    if (!rruleString.startsWith(rrulePrefix)) {
      throw RRuleException(
          "Missing '$rrulePrefix' in rrule string: $rruleString");
    }
    rruleString = rruleString.substring(rrulePrefix.length);
    final rruleTokens = rruleString.trim().split(";");
    if (rruleTokens.length == 0 || !rruleTokens[0].startsWith("FREQ=")) {
      throw RRuleException(
          "Missing FREQ at the beggining of the rrule $rruleString.");
    }
    rruleTokens.forEach((rruleToken) {
      final tokenType = rruleToken.split("=")[0];
      switch (tokenType) {
        case "FREQ":
          parseFreq(rruleToken);
          break;
        case "UNTIL":
          parseUntil(rruleToken);
          break;
        case "COUNT":
          parseCount(rruleToken);
          break;
        case "INTERVAL":
          parseInterval(rruleToken);
          break;
        case "BYSECOND":
          parseBySecond(rruleToken);
          break;
        case "BYMINUTE":
          parseByMinute(rruleToken);
          break;
        case "BYHOUR":
          parseByHour(rruleToken);
          break;
        case "BYDAY":
          parseByDay(rruleToken);
          break;
        case "BYMONTHDAY":
          parseByMonthDay(rruleToken);
          break;
        case "BYYEARDAY":
          parseByDay(rruleToken);
          break;
        case "BYWEEKNO":
          parseByWeekNo(rruleToken);
          break;
        case "BYMONTH":
          parseByMonth(rruleToken);
          break;
        case "BYSETPOS":
          parseBySetPos(rruleToken);
          break;
        case "WKST":
          parseWkst(rruleToken);
          break;
        default:
          throw RRuleException(
              "Invalid token $tokenType in rrule $rruleString");
      }
    });
    return RRule();
  }

  Iterable<DateTime> between(DateTime start, DateTime stop) {
    final events = List<DateTime>();
    return events.map((f) => f);
  }

  bool repeatsForever() {
    return until == null && count == null;
  }

  String toString() {
    return "";
  }

  Iterable<DateTime> all() {
    final events = List<DateTime>();
    return events.map((f) => f);
  }
}
