import 'dart:io';
import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/src/utiliti/currency_onversions_method.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<File?> pickSingleImage() async {
  try {
    var file = await FilePicker.platform.pickFiles(type: FileType.image);
    if (file != null && file.files.isNotEmpty) {
      return File(file.files.first.path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

Future<List<File>> pickImage() async {
  List<File> images = [];

  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

//Convert currency to the base currency_converter_services
double? basedCurrencyConvertion(String productCurrency, double amount,
    List<Map<String, dynamic>> exchangeRates) {
  double? finalAmount = 0.0;
  CurrencyConversionMethod currencyService =
      CurrencyConversionMethod(exchangeRates: exchangeRates);
  if ((productCurrency != currencyChoosed) && (productCurrency != "GBP")) {
    double? convertedAmount = currencyService.convertCurrency(
        productCurrency, currencyChoosed, amount) as double?;
    finalAmount = convertedAmount;
    return finalAmount;
  } else if (productCurrency == "GBP") {
    double? convertedAmount = currencyService.convertCurrency(
        currencyChoosed, productCurrency, amount) as double?;
    finalAmount = convertedAmount;
    return finalAmount;
  } else {
    finalAmount = amount;
    return finalAmount;
  }
}

class MyProgressor extends StatelessWidget {
  const MyProgressor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 1,
      color: AppColor.darkOrange,
      backgroundColor: Colors.white,
    );
  }
}

List<String> getStatesByCountry(String country) {
  switch (country) {
    case 'Nigeria':
      return [
        "Abia",
        "Adamawa",
        "Akwa Ibom",
        "Anambra",
        "Bauchi",
        "Bayelsa",
        "Benue",
        "Borno",
        "Cross River",
        "Delta",
        "Ebonyi",
        "Edo",
        "Ekiti",
        "Enugu",
        "Gombe",
        "Imo",
        "Jigawa",
        "Kaduna",
        "Kano",
        "Katsina",
        "Kebbi",
        "Kogi",
        "Kwara",
        "Lagos",
        "Nasarawa",
        "Niger",
        "Ogun",
        "Ondo",
        "Osun",
        "Oyo",
        "Plateau",
        "Rivers",
        "Sokoto",
        "Taraba",
        "Yobe",
        "Zamfara",
        "Federal Capital Territory (FCT)"
      ];
    case 'United Kingdom':
      return ["England", "Scotland", "Wales", "Northern Ireland"];
    default:
      return [];
  }
}

// based URL
String basedUrl = "https://service.phopis.com/bellabanga";

//IMAGE FILE URL
String imageUrl = "https://bellabanga.s3.amazonaws.com/";

List currencyList = ["USD", "NGN", "GBP"];

String currencyChoosed = currencyList.first;

String currencySymbolConveeter(String cCode) {
  String currencyCodeConverted = '';
  if (cCode == 'NGN') {
    currencyCodeConverted = '\u20A6'; // Naira Sign
  } else if (cCode == "USD") {
    currencyCodeConverted = "\$";
  } else if (cCode == 'GBP') {
    currencyCodeConverted = "£";
  } else {
    // ignore: avoid_print
    print("Invalid Code");
  }

  return currencyCodeConverted;
}

Future<String> mytoken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('Bearer');
  return token!;
}
