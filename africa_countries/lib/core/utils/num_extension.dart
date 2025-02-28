import 'package:intl/intl.dart';

extension NumFormatting on num {
  String formatNumber() {
    return NumberFormat.decimalPattern().format(this);
  }
}
