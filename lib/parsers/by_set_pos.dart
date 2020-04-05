import 'package:rrule/parsers/utils.dart';
import 'package:rrule/exceptions.dart';

final _tokenValueRegex = RegExp(r"^[-+]?\d{1,3}(,[-+]?\d{1,3})*$");
const _minValue = -366;
const _maxValue = 366;
const _tokenType = "BYSETPOS";

List<int> parseBySetPos(String tokenString) {
  if (failsBasicValidation("$_tokenType", tokenString)) {
    throw BySetPosException(
        "$_tokenType token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("$_tokenType=".length);
  if (!_tokenValueRegex.hasMatch(tokenValue)) {
    throw BySetPosException(
        "$_tokenType token has an invalid value: $tokenValue");
  }
  final numbers = tokenValue.split(",").map(int.parse).toList();
  numbers.forEach((number) {
    if (number < _minValue || number > _maxValue || number == 0) {
      throw BySetPosException(
          "$_tokenType token contains integers outside range [$_minValue - -1] [1 - $_maxValue]: $tokenValue");
    }
  });
  return numbers;
}
