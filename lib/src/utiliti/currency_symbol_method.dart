// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class CurrencySymbolMethod{
  Future<String?> getCurrencySymbol(String currencyCode) async {
  final url = Uri.parse('https://service.phopis.com/bellabanga/api/currency/get_all_active');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['success'] == true) {
        final List<dynamic> currencies = responseData['payload'];
        final currency = currencies.firstWhere(
          (c) => c['code'] == currencyCode,
          orElse: () => null,
        );

        if (currency != null) {
          return currency['symbol'];
        }
      }
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}
}
