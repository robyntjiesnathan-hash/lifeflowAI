import 'package:intl/intl.dart';

/// Formats [amount] as [currencyCode] (e.g. `'USD'`, `'JPY'`, `'INR'`),
/// using ICU data (bundled with `intl`) to pick the right symbol and decimal
/// digit count per currency (e.g. no decimals for JPY/KRW) rather than
/// assuming `$`-and-two-decimals for every currency.
String formatCurrency(num amount, String currencyCode) {
  return NumberFormat.simpleCurrency(name: currencyCode).format(amount);
}
