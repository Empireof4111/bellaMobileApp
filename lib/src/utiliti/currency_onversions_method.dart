class CurrencyConversionMethod {
  List<Map<String, dynamic>> exchangeRates;

  CurrencyConversionMethod({required this.exchangeRates});

  Object convertCurrency(String fromCode, String toCode, double amount) {
    Map<String, dynamic>? rateInfo = exchangeRates.firstWhere(
      (rate) => rate['fromCode'] == fromCode && rate['toCode'] == toCode,
      orElse: () => Map<String, dynamic>.from({}),
    );


    // ignore: unnecessary_null_comparison
          if (rateInfo != null) {
        if (rateInfo['rate'] != null) {
          double rate = rateInfo['rate'];
          if (fromCode == "NGN" || (fromCode == "USD" && toCode == "GBP")) {
            return amount / rate;
          } else {
            return amount * rate;
          }
        } else {
          // ignore: avoid_print
          print('Error: Exchange rate is null for $fromCode to $toCode');
          return amount;
        }
      } else {
        // ignore: avoid_print
        print('Error: Exchange rate not found for $fromCode to $toCode');
        return amount;
      }
  }
}

