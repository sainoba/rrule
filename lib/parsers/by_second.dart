import 'package:rrule/parsers/utils.dart';
import 'package:rrule/exceptions.dart';

final _tokenValueRegex = RegExp(r"^\d\d?(,\d\d?)*$");
const _minValue = 0;
const _maxValue = 60;
const _tokenType = "BYSECOND";

List<int> parseBySecond(String tokenString) {
  if (failsBasicValidation("$_tokenType", tokenString)) {
    throw BySecondException(
        "$_tokenType token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("$_tokenType=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw BySecondException(
        "$_tokenType token has an invalid value: $tokenValue");
  }
  final numbers = tokenValue.split(",").map(int.parse).toList();
  numbers.forEach((number) {
    if (number < _minValue || number > _maxValue) {
      throw BySecondException(
          "$_tokenType token contains integers outside range [$_minValue-$_maxValue]: $tokenValue");
    }
  });
  return numbers;
}
