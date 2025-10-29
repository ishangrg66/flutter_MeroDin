import 'package:nepali_utils/nepali_utils.dart';

class DateConverter {
  static String englishToNepali(DateTime date) {
    final nepaliDate = NepaliDateTime.fromDateTime(date);
    return NepaliUnicode.convert(nepaliDate.toString());
  }

  static NepaliDateTime toNepaliDateTime(DateTime date) {
    return NepaliDateTime.fromDateTime(date);
  }
}
