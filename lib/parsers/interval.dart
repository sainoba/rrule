import 'package:rrule/exceptions.dart';
import 'package:rrule/parsers/utils.dart';

final _tokenValueRegex = RegExp(r"^\d+?$");

int parseInterval(String tokenString) {
  if (failsBasicValidation("INTERVAL", tokenString)) {
    throw IntervalException(
        "Interval token has an invalid format: $tokenString");
  }

  final tokenValue = tokenString.substring("INTERVAL=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw IntervalException("Interval token has an invalid value: $tokenValue");
  }
  final interval = int.tryParse(tokenValue);

  if (interval == null) {
    throw IntervalException(
        "Interval token has an invalid value: $tokenString");
  }
  return interval;
}
