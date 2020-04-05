import 'package:rrule/parsers/utils.dart';
import 'package:rrule/exceptions.dart';
import 'package:rrule/weekdays.dart';

final _tokenValueRegex = RegExp(
    r"^([+-]?\d\d?)?(SU|MO|TU|WE|TH|FR|SA)(,([+-]?\d\d?)?(SU|MO|TU|WE|TH|FR|SA))*$");
const _minValue = -53;
const _maxValue = 53;
const _tokenType = "BYDAY";

List<WeekDayItem> parseByDay(String tokenString) {
  if (failsBasicValidation("$_tokenType", tokenString)) {
    throw ByDayException(
        "$_tokenType token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("$_tokenType=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw ByDayException("$_tokenType token has an invalid value: $tokenValue");
  }
  final tokenValues = tokenValue.split(",").map((weekDayToken) {
    final tokenLength = weekDayToken.length;
    final ordwk = int.parse(weekDayToken.substring(0, tokenLength - 2));
    final weekDay = stringToWeekDay(weekDayToken.substring(tokenLength - 2));
    if (ordwk < _minValue || ordwk > _maxValue || ordwk == 0) {
      throw ByDayException(
          "$_tokenType token contains integers outside range [$_minValue - -1] [1 - $_maxValue]: $tokenValue");
    }

    return WeekDayItem(weekDay, ordwk);
  }).toList();
  return tokenValues;
}
