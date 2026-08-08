/// A currency selectable as the user's budget currency (`BudgetProfile.currency`).
class Currency {
  const Currency({required this.code, required this.name, required this.flagEmoji});

  /// ISO 4217 code, e.g. `'USD'` — matches what `NumberFormat.simpleCurrency`
  /// (see `currency_format.dart`) expects for symbol/decimal-digit lookup.
  final String code;
  final String name;
  final String flagEmoji;
}

/// The world's major/most-traded currencies, roughly ordered by global usage.
/// Covers every G20 economy's currency plus the other most commonly used
/// currencies for personal finance apps.
const List<Currency> currencyCatalog = [
  Currency(code: 'USD', name: 'US Dollar', flagEmoji: '🇺🇸'),
  Currency(code: 'EUR', name: 'Euro', flagEmoji: '🇪🇺'),
  Currency(code: 'GBP', name: 'British Pound', flagEmoji: '🇬🇧'),
  Currency(code: 'JPY', name: 'Japanese Yen', flagEmoji: '🇯🇵'),
  Currency(code: 'CNY', name: 'Chinese Yuan', flagEmoji: '🇨🇳'),
  Currency(code: 'INR', name: 'Indian Rupee', flagEmoji: '🇮🇳'),
  Currency(code: 'AUD', name: 'Australian Dollar', flagEmoji: '🇦🇺'),
  Currency(code: 'CAD', name: 'Canadian Dollar', flagEmoji: '🇨🇦'),
  Currency(code: 'CHF', name: 'Swiss Franc', flagEmoji: '🇨🇭'),
  Currency(code: 'HKD', name: 'Hong Kong Dollar', flagEmoji: '🇭🇰'),
  Currency(code: 'SGD', name: 'Singapore Dollar', flagEmoji: '🇸🇬'),
  Currency(code: 'KRW', name: 'South Korean Won', flagEmoji: '🇰🇷'),
  Currency(code: 'SEK', name: 'Swedish Krona', flagEmoji: '🇸🇪'),
  Currency(code: 'NOK', name: 'Norwegian Krone', flagEmoji: '🇳🇴'),
  Currency(code: 'DKK', name: 'Danish Krone', flagEmoji: '🇩🇰'),
  Currency(code: 'NZD', name: 'New Zealand Dollar', flagEmoji: '🇳🇿'),
  Currency(code: 'MXN', name: 'Mexican Peso', flagEmoji: '🇲🇽'),
  Currency(code: 'BRL', name: 'Brazilian Real', flagEmoji: '🇧🇷'),
  Currency(code: 'ZAR', name: 'South African Rand', flagEmoji: '🇿🇦'),
  Currency(code: 'RUB', name: 'Russian Ruble', flagEmoji: '🇷🇺'),
  Currency(code: 'TRY', name: 'Turkish Lira', flagEmoji: '🇹🇷'),
  Currency(code: 'AED', name: 'UAE Dirham', flagEmoji: '🇦🇪'),
  Currency(code: 'SAR', name: 'Saudi Riyal', flagEmoji: '🇸🇦'),
  Currency(code: 'THB', name: 'Thai Baht', flagEmoji: '🇹🇭'),
  Currency(code: 'IDR', name: 'Indonesian Rupiah', flagEmoji: '🇮🇩'),
  Currency(code: 'MYR', name: 'Malaysian Ringgit', flagEmoji: '🇲🇾'),
  Currency(code: 'PHP', name: 'Philippine Peso', flagEmoji: '🇵🇭'),
  Currency(code: 'VND', name: 'Vietnamese Dong', flagEmoji: '🇻🇳'),
  Currency(code: 'PLN', name: 'Polish Zloty', flagEmoji: '🇵🇱'),
  Currency(code: 'ILS', name: 'Israeli Shekel', flagEmoji: '🇮🇱'),
  Currency(code: 'EGP', name: 'Egyptian Pound', flagEmoji: '🇪🇬'),
  Currency(code: 'NGN', name: 'Nigerian Naira', flagEmoji: '🇳🇬'),
  Currency(code: 'PKR', name: 'Pakistani Rupee', flagEmoji: '🇵🇰'),
  Currency(code: 'BDT', name: 'Bangladeshi Taka', flagEmoji: '🇧🇩'),
  Currency(code: 'ARS', name: 'Argentine Peso', flagEmoji: '🇦🇷'),
  Currency(code: 'CLP', name: 'Chilean Peso', flagEmoji: '🇨🇱'),
  Currency(code: 'COP', name: 'Colombian Peso', flagEmoji: '🇨🇴'),
];

Currency? currencyByCode(String code) {
  for (final currency in currencyCatalog) {
    if (currency.code == code) return currency;
  }
  return null;
}
