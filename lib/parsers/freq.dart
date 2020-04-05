import 'package:rrule/frequencies.dart';
import 'package:rrule/exceptions.dart';
import 'package:rrule/parsers/utils.dart';

Frequency parseFreq(String tokenString) {
  if (failsBasicValidation("FREQ", tokenString)) {
    throw FrequencyException(
        "Frequency token has an invalid format: $tokenString");
  }
  final tokenValue = tokenString.substring("FREQ=".length);
  switch (tokenValue) {
    case "YEARLY":
      return Frequency.YEARLY;
      break;
    case "MONTHLY":
      return Frequency.MONTHLY;
      break;
    case "WEEKLY":
      return Frequency.WEEKLY;
      break;
    case "DAILY":
      return Frequency.DAILY;
      break;
    case "HOURLY":
      return Frequency.HOURLY;
      break;
    case "MINUTELY":
      return Frequency.MINUTELY;
      break;
    case "SECONDLY":
      return Frequency.SECONDLY;
      break;
    default:
      throw FrequencyException(
          "Frequency token has an invalid value: $tokenValue");
  }
}
