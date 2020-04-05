import 'package:rrule/exceptions.dart';
import 'package:rrule/parsers/utils.dart';

final _countRegex = RegExp(r"^\d+?$");

int parseCount(String tokenString) {
  if (failsBasicValidation("COUNT", tokenString)) {
    throw CountException("Count token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("COUNT=".length);
  if (!_countRegex.hasMatch(tokenValue)) {
    throw CountException("Count token has an invalid value: $tokenValue");
  }
  final count = int.tryParse(tokenValue);
  if (count == null) {
    throw CountException("Count token has an invalid value: $tokenValue");
  }
  return count;
}
