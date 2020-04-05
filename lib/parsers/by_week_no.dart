import 'package:rrule/parsers/utils.dart';
import 'package:rrule/exceptions.dart';

final _tokenValueRegex = RegExp(r"^[-+]?\d\d?(,[-+]?\d\d?)*$");
const _minValue = -53;
const _maxValue = 53;
const _tokenType = "BYWEEKNO";

List<int> parseByWeekNo(String tokenString) {
  if (failsBasicValidation("$_tokenType", tokenString)) {
    throw ByWeekNoException(
        "$_tokenType token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("$_tokenType=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw ByWeekNoException(
        "$_tokenType token has an invalid value: $tokenValue");
  }
  final numbers = tokenValue.split(",").map(int.parse).toList();
  numbers.forEach((number) {
    if (number < _minValue || number > _maxValue || number == 0) {
      throw ByWeekNoException(
          "$_tokenType token contains integers outside range [$_minValue - -1] [1 - $_maxValue]: $tokenValue");
    }
  });
  return numbers;
}
