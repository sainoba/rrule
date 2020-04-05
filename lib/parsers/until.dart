import 'package:rrule/exceptions.dart';
import 'package:rrule/parsers/utils.dart';

final _untilRegex = RegExp(r"^\d{8}(T\d{6}Z?)?$");

DateTime parseUntil(String tokenString) {
  if (failsBasicValidation("UNTIL", tokenString)) {
    throw UntilException("Until token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("UNTIL=".length);
  if (!_untilRegex.hasMatch(tokenValue)) {
    throw UntilException("Until token has an invalid value: $tokenValue");
  }
  return DateTime.parse(tokenValue);
}
