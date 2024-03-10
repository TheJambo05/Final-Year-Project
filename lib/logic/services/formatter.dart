import 'package:intl/intl.dart';

class Formatter {
  static String formatPrice(int price) {
    final numberFormat = NumberFormat("Rs #,##,###");
    return numberFormat.format(price);
  }
}
