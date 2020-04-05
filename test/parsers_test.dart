import 'package:test/test.dart';
import 'package:rrule/parsers/freq.dart';
import 'package:rrule/parsers/until.dart';
import 'package:rrule/parsers/count.dart';
import 'package:rrule/parsers/interval.dart';
import 'package:rrule/parsers/by_second.dart';
import 'package:rrule/parsers/by_minute.dart';
import 'package:rrule/parsers/by_hour.dart';
import 'package:rrule/parsers/by_day.dart';
import 'package:rrule/parsers/by_month_day.dart';
import 'package:rrule/parsers/by_year_day.dart';
import 'package:rrule/parsers/by_week_no.dart';
import 'package:rrule/parsers/by_month.dart';
import 'package:rrule/parsers/by_set_pos.dart';
import 'package:rrule/parsers/wkst.dart';
import 'package:rrule/exceptions.dart';
import 'package:rrule/frequencies.dart';
import 'package:rrule/weekdays.dart';

// import 'package:test/test.dart';
// import 'package:todo_flutter/rrule/parser2.dart';

void main() {
  group("Frequency -", () {
    const emptyString = "";
    const invalidFrequency = "FREQ=invalid";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseFreq(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is FrequencyException, isTrue);
      expect(err.toString(), 'Frequency token has an invalid format: ');
    });
    test("Throws exception with invalid frequency", () {
      Exception err;
      try {
        parseFreq(invalidFrequency);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is FrequencyException, isTrue);
      expect(err.toString(), 'Frequency token has an invalid value: invalid');
    });
    final inputsToExpected = {
      "YEARLY": Frequency.YEARLY,
      "MONTHLY": Frequency.MONTHLY,
      "WEEKLY": Frequency.WEEKLY,
      "DAILY": Frequency.DAILY,
      "HOURLY": Frequency.HOURLY,
      "MINUTELY": Frequency.MINUTELY,
      "SECONDLY": Frequency.SECONDLY,
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseFreq("FREQ=$input"), expected);
      });
    });
  });

  group("Until -", () {
    const emptyString = "";
    const invalidUntil = "UNTIL=invalid";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseUntil(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is UntilException, isTrue);
      expect(err.toString(), 'Until token has an invalid format: ');
    });
    test("Throws exception with invalid frequency", () {
      Exception err;
      try {
        parseUntil(invalidUntil);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is UntilException, isTrue);
      expect(err.toString(), 'Until token has an invalid value: invalid');
    });
    final inputsToExpected = {
      "20130130T231234Z": DateTime.utc(2013, 1, 30, 23, 12, 34),
      "20130130T231234": DateTime(2013, 1, 30, 23, 12, 34),
      "20130130": DateTime(2013, 1, 30),
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseUntil("UNTIL=$input"), expected);
      });
    });
  });

  group("Count -", () {
    const emptyString = "";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseCount(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is CountException, isTrue);
      expect(err.toString(), 'Count token has an invalid format: ');
    });

    const invalidInputsToExpected = ["-1", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseCount("COUNT=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is CountException, isTrue,
            reason: "The exception should have type CountException.");
        expect(err.toString(), 'Count token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "0": 0,
      "11": 11,
      "333": 333,
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseCount("COUNT=$input"), expected);
      });
    });
  });

  group("Interval -", () {
    const emptyString = "";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseInterval(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is IntervalException, isTrue);
      expect(err.toString(), 'Interval token has an invalid format: ');
    });

    const invalidInputsToExpected = ["-1", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseInterval("INTERVAL=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is IntervalException, isTrue,
            reason: "The exception should have type IntervalException.");
        expect(err.toString(), 'Interval token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "0": 0,
      "11": 11,
      "333": 333,
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseInterval("INTERVAL=$input"), expected);
      });
    });
  });

  group("BYSECOND -", () {
    const emptyString = "";
    const numberOutsideRange = "61";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseBySecond(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is BySecondException, isTrue);
      expect(
          err.toString(), 'BYSECOND token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseBySecond("BYSECOND=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is BySecondException, isTrue);
      expect(err.toString(),
          'BYSECOND token contains integers outside range [0-60]: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["-1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseBySecond("BYSECOND=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is BySecondException, isTrue,
            reason: "The exception should have type BySecondException.");
        expect(err.toString(), 'BYSECOND token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "0": [0],
      "01": [1],
      "1": [1],
      "60": [60],
      "6,7,8,7": [6, 7, 8, 7],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseBySecond("BYSECOND=$input"), expected);
      });
    });
  });

  group("BYMINUTE -", () {
    const emptyString = "";
    const numberOutsideRange = "60";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseByMinute(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByMinuteException, isTrue);
      expect(
          err.toString(), 'BYMINUTE token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseByMinute("BYMINUTE=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByMinuteException, isTrue);
      expect(err.toString(),
          'BYMINUTE token contains integers outside range [0-59]: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["-1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseByMinute("BYMINUTE=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is ByMinuteException, isTrue,
            reason: "The exception should have type ByMinuteException.");
        expect(err.toString(), 'BYMINUTE token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "0": [0],
      "01": [1],
      "1": [1],
      "59": [59],
      "6,7,8,7": [6, 7, 8, 7],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseByMinute("BYMINUTE=$input"), expected);
      });
    });
  });

  group("BYHOUR -", () {
    const emptyString = "";
    const numberOutsideRange = "24";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseByHour(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByHourException, isTrue);
      expect(
          err.toString(), 'BYHOUR token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseByHour("BYHOUR=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByHourException, isTrue);
      expect(err.toString(),
          'BYHOUR token contains integers outside range [0-23]: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["-1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseByHour("BYHOUR=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is ByHourException, isTrue,
            reason: "The exception should have type ByHourException.");
        expect(err.toString(), 'BYHOUR token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "0": [0],
      "01": [1],
      "1": [1],
      "23": [23],
      "6,7,8,7": [6, 7, 8, 7],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseByHour("BYHOUR=$input"), expected);
      });
    });
  });

  group("BYDAY -", () {
    const emptyString = "";
    const numberOutsideRange = "54";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseByDay(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByDayException, isTrue);
      expect(err.toString(), 'BYDAY token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseByDay("BYDAY=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByDayException, isTrue);
      expect(err.toString(),
          'BYDAY token has an invalid value: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["--1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseByDay("BYDAY=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is ByDayException, isTrue,
            reason: "The exception should have type ByDayException.");
        expect(err.toString(), 'BYDAY token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    final inputsToExpected = {
      "01MO": [WeekDayItem(WeekDay.MONDAY, 1)],
      "+1TU": [WeekDayItem(WeekDay.TUESDAY, 1)],
      "-23WE": [WeekDayItem(WeekDay.WEDNESDAY, -23)],
      "6TH,-7FR,8SA,+7SU": [
        WeekDayItem(WeekDay.THURSDAY, 6),
        WeekDayItem(WeekDay.FRIDAY, -7),
        WeekDayItem(WeekDay.SATURDAY, 8),
        WeekDayItem(WeekDay.SUNDAY, 7)
      ],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseByDay("BYDAY=$input"), expected);
      });
    });
  });

  group("BYMONTHDAY -", () {
    const emptyString = "";
    const numberOutsideRange = "32";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseByMonthDay(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByMonthDayException, isTrue);
      expect(err.toString(),
          'BYMONTHDAY token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseByMonthDay("BYMONTHDAY=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByMonthDayException, isTrue);
      expect(err.toString(),
          'BYMONTHDAY token contains integers outside range [1-31]: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["--1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseByMonthDay("BYMONTHDAY=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is ByMonthDayException, isTrue,
            reason: "The exception should have type ByMonthDayException.");
        expect(err.toString(), 'BYMONTHDAY token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "01": [1],
      "1": [1],
      "23": [23],
      "6,1,8,+7": [6, 1, 8, 7],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseByMonthDay("BYMONTHDAY=$input"), expected);
      });
    });
  });

  group("BYYEARDAY -", () {
    const emptyString = "";
    const numberOutsideRange = "367";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseByYearDay(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByYearDayException, isTrue);
      expect(err.toString(),
          'BYYEARDAY token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseByYearDay("BYYEARDAY=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByYearDayException, isTrue);
      expect(err.toString(),
          'BYYEARDAY token contains integers outside range [-366 - -1] [1 - 366]: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["--1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseByYearDay("BYYEARDAY=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is ByYearDayException, isTrue,
            reason: "The exception should have type ByYearDayException.");
        expect(err.toString(), 'BYYEARDAY token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "01": [1],
      "1": [1],
      "23": [23],
      "6,1,8,+7,366,-365": [6, 1, 8, 7, 366, -365],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseByYearDay("BYYEARDAY=$input"), expected);
      });
    });
  });

  group("BYWEEKNO -", () {
    const emptyString = "";
    const numberOutsideRange = "54";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseByWeekNo(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByWeekNoException, isTrue);
      expect(
          err.toString(), 'BYWEEKNO token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseByWeekNo("BYWEEKNO=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByWeekNoException, isTrue);
      expect(err.toString(),
          'BYWEEKNO token contains integers outside range [-53 - -1] [1 - 53]: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["--1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseByWeekNo("BYWEEKNO=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is ByWeekNoException, isTrue,
            reason: "The exception should have type ByWeekNoException.");
        expect(err.toString(), 'BYWEEKNO token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "01": [1],
      "1": [1],
      "23": [23],
      "6,1,8,+7,53": [6, 1, 8, 7, 53],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseByWeekNo("BYWEEKNO=$input"), expected);
      });
    });
  });

  group("BYMONTH -", () {
    const emptyString = "";
    const numberOutsideRange = "13";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseByMonth(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByMonthException, isTrue);
      expect(
          err.toString(), 'BYMONTH token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseByMonth("BYMONTH=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is ByMonthException, isTrue);
      expect(err.toString(),
          'BYMONTH token contains integers outside range [1-12]: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["--1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseByMonth("BYMONTH=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is ByMonthException, isTrue,
            reason: "The exception should have type ByMonthException.");
        expect(err.toString(), 'BYMONTH token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "01": [1],
      "1": [1],
      "12": [12],
      "6,1,8,7,11": [6, 1, 8, 7, 11],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseByMonth("BYMONTH=$input"), expected);
      });
    });
  });

  group("BYSETPOS -", () {
    const emptyString = "";
    const numberOutsideRange = "367";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseBySetPos(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is BySetPosException, isTrue);
      expect(
          err.toString(), 'BYSETPOS token has an invalid format: $emptyString');
    });
    test("Throws exception with number outside range", () {
      Exception err;
      try {
        parseBySetPos("BYSETPOS=$numberOutsideRange");
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is BySetPosException, isTrue);
      expect(err.toString(),
          'BYSETPOS token contains integers outside range [-366 - -1] [1 - 366]: $numberOutsideRange');
    });

    const invalidInputsToExpected = ["--1", "1, 2", "invalid"];
    invalidInputsToExpected.forEach((input) {
      test("Throws exception with invalid value: $input", () {
        Exception err;
        try {
          parseBySetPos("BYSETPOS=$input");
        } catch (e) {
          err = e;
        }

        expect(err, isNotNull, reason: "It should thrown and exception.");
        expect(err is BySetPosException, isTrue,
            reason: "The exception should have type BySetPosException.");
        expect(err.toString(), 'BYSETPOS token has an invalid value: $input',
            reason: "The exception should have the same message.");
      });
    });
    const inputsToExpected = {
      "-01": [-1],
      "1": [1],
      "12": [12],
      "6,1,8,7,-366": [6, 1, 8, 7, -366],
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseBySetPos("BYSETPOS=$input"), expected);
      });
    });
  });

  group("Wkst -", () {
    const emptyString = "";
    const invalidWkst = "WKST=invalid";
    test("Throws exception with emtpy string", () {
      Exception err;
      try {
        parseWkst(emptyString);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is WkstException, isTrue);
      expect(err.toString(), 'WKST token has an invalid format: ');
    });
    test("Throws exception with invalid frequency", () {
      Exception err;
      try {
        parseWkst(invalidWkst);
      } catch (e) {
        err = e;
      }

      expect(err, isNotNull);
      expect(err is WkstException, isTrue);
      expect(err.toString(), 'WKST token has an invalid value: invalid');
    });
    final inputsToExpected = {
      "MO": WeekDay.MONDAY,
      "TU": WeekDay.TUESDAY,
      "WE": WeekDay.WEDNESDAY,
      "TH": WeekDay.THURSDAY,
      "FR": WeekDay.FRIDAY,
      "SA": WeekDay.SATURDAY,
      "SU": WeekDay.SUNDAY,
    };
    inputsToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(parseWkst("WKST=$input"), expected);
      });
    });
  });
}
