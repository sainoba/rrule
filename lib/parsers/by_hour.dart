import 'package:rrule/parsers/utils.dart';
import 'package:rrule/exceptions.dart';

final _tokenValueRegex = RegExp(r"^\d\d?(,\d\d?)*$");
const _minValue = 0;
const _maxValue = 23;
const _tokenType = "BYHOUR";

List<int> parseByHour(String tokenString) {
  if (failsBasicValidation("$_tokenType", tokenString)) {
    throw ByHourException(
        "$_tokenType token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("$_tokenType=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw ByHourException(
        "$_tokenType token has an invalid value: $tokenValue");
  }
  final numbers = tokenValue.split(",").map(int.parse).toList();
  numbers.forEach((number) {
    if (number < _minValue || number > _maxValue) {
      throw ByHourException(
          "$_tokenType token contains integers outside range [$_minValue-$_maxValue]: $tokenValue");
    }
  });
  return numbers;
}
