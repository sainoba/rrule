import 'package:rrule/parsers/utils.dart';
import 'package:rrule/exceptions.dart';

final _tokenValueRegex = RegExp(r"^\d\d?(,\d\d?)*$");
const _minValue = 1;
const _maxValue = 12;
const _tokenType = "BYMONTH";

List<int> parseByMonth(String tokenString) {
  if (failsBasicValidation("$_tokenType", tokenString)) {
    throw ByMonthException(
        "$_tokenType token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("$_tokenType=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw ByMonthException(
        "$_tokenType token has an invalid value: $tokenValue");
  }
  final numbers = tokenValue.split(",").map(int.parse).toList();
  numbers.forEach((number) {
    if (number < _minValue || number > _maxValue) {
      throw ByMonthException(
          "$_tokenType token contains integers outside range [$_minValue-$_maxValue]: $tokenValue");
    }
  });
  return numbers;
}
