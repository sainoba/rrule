import 'package:rrule/parsers/utils.dart';
import 'package:rrule/exceptions.dart';

final _tokenValueRegex = RegExp(r"^[-+]?\d\d?(,[-+]?\d\d?)*$");
const _minValue = 1;
const _maxValue = 31;
const _tokenType = "BYMONTHDAY";

List<int> parseByMonthDay(String tokenString) {
  if (failsBasicValidation("$_tokenType", tokenString)) {
    throw ByMonthDayException(
        "$_tokenType token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("$_tokenType=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw ByMonthDayException(
        "$_tokenType token has an invalid value: $tokenValue");
  }
  final numbers = tokenValue.split(",").map(int.parse).toList();
  numbers.forEach((number) {
    if (number < _minValue || number > _maxValue) {
      throw ByMonthDayException(
          "$_tokenType token contains integers outside range [$_minValue-$_maxValue]: $tokenValue");
    }
  });
  return numbers;
}
