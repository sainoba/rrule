import 'dart:math';

List<int> parseByXIntList(
    String tokenId, Function exception, String byXString) {
  if (!byXString.startsWith("$tokenId=")) {
    throw exception("Missing $tokenId= keyword: $byXString");
  }
  final byXTokens = byXString.trim().split("=");
  if (byXTokens.length != 2) {
    throw exception("$tokenId token has an invalid format: $byXString");
  }
  final byXValue = byXTokens[1].replaceAll(RegExp(r"\s+\b|\b\s"), "");
  if (!RegExp(r"^-?\d*(,-?\d*)*$").hasMatch(byXValue)) {
    throw exception("Invalid value for $tokenId $byXValue");
  }

  final byX = List<int>();
  byXValue.split(",").forEach((value) {
    final valueInt = int.tryParse(value);
    if (valueInt == null) {
      throw exception("Invalid value for $tokenId token $value");
    }
    byX.add(valueInt);
  });
  return byX;
}

List<int> parseListOfInts(String listString, {bool skipDuplicates: true}) {
  final processedValues = Set<int>();
  final intList = List<int>();
  listString.split(",").forEach((value) {
    final number = int.parse(value);
    if (skipDuplicates) {
      if (processedValues.add(number)) {
        intList.add(number);
      }
    } else {
      intList.add(number);
    }
  });
  return intList;
}

bool failsBasicValidation(String tokenId, String tokenString) {
  final prefix = "$tokenId=";
  var isValid = true;
  isValid &= tokenString.startsWith(prefix);
  isValid &=
      tokenString.substring(min(prefix.length, tokenString.length)).length != 0;
  return !isValid;
}
