import 'package:rrule/parsers/utils.dart';
import 'package:rrule/exceptions.dart';
import 'package:rrule/weekdays.dart';

final _tokenValueRegex = RegExp(r"^(MO|TU|WE|TH|FR|SA|SU)$");
const _tokenType = "WKST";

WeekDay parseWkst(String tokenString) {
  if (failsBasicValidation("$_tokenType", tokenString)) {
    throw WkstException(
        "$_tokenType token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("$_tokenType=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw WkstException("$_tokenType token has an invalid value: $tokenValue");
  }
  return stringToWeekDay(tokenValue);
}
