import 'package:intl/intl.dart';

// currency helper
String hCurrency(double value) {
  return NumberFormat.currency(
    symbol: '',
    decimalDigits: 2,
  ).format(value);
}
