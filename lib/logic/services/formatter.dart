import 'package:intl/intl.dart';

class Formatter {
  static String formatPrice(num price) {
    final numberFormat = NumberFormat("Rs #,##,###");
    return numberFormat.format(price);
  }
}
