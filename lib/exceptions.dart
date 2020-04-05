/// Base class for RRule exceptions
class RRuleException implements Exception {
  final String message;
  RRuleException(this.message);

  @override
  String toString() => message;
}

class FrequencyException extends RRuleException {
  FrequencyException(message) : super(message);
}

class UntilException extends RRuleException {
  UntilException(message) : super(message);
}

class CountException extends RRuleException {
  CountException(message) : super(message);
}

class IntervalException extends RRuleException {
  IntervalException(message) : super(message);
}

class WkstException extends RRuleException {
  WkstException(message) : super(message);
}

class ByDayException extends RRuleException {
  ByDayException(message) : super(message);
}

class ByMonthException extends RRuleException {
  ByMonthException(message) : super(message);
}

class BySetPosException extends RRuleException {
  BySetPosException(message) : super(message);
}

class ByMonthDayException extends RRuleException {
  ByMonthDayException(message) : super(message);
}

class ByYearDayException extends RRuleException {
  ByYearDayException(message) : super(message);
}

class ByWeekNoException extends RRuleException {
  ByWeekNoException(message) : super(message);
}

class ByHourException extends RRuleException {
  ByHourException(message) : super(message);
}

class ByMinuteException extends RRuleException {
  ByMinuteException(message) : super(message);
}

class BySecondException extends RRuleException {
  BySecondException(message) : super(message);
}
