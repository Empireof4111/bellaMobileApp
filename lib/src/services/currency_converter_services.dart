import 'dart:convert';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:http/http.dart' as http;


class CurrencyConversionApi {
  static Future<List<Map<String, dynamic>>> getExchangeRates() async {
    final response = await http.put(Uri.parse('$basedUrl/api/fx/refresh'),
    headers: {
      "Content-Type": "application/json",
      "Accept" : "application/json"
    }
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['payload'];
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}
