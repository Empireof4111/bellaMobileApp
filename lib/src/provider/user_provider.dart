// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:bella_banga/src/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import necessary dependencies

class UserProvider extends ChangeNotifier {
  User _user = User(
    // initialize with default values or empty strings
        id: null, 
        role: '', 
        uuid: '', 
        name: '', 
        businessName: '',
        businessEmail: '', 
        businessMobile: '', 
        businessAddress: '', 
        businessCacLink: '', 
        businessNepcLink: '', 
        description: '', 
        handle: '',
        idType: '', 
        idLink: '', 
        personalEmail: '', 
        email: '', 
        isVerified: '', 
        isSubscribed: '', 
        isEnabled: false, 
        gender: '', 
        kycLevel: null, 
        categoryId: '', 
        accountType: '',
        mobile: '', 
        preferredCurrency: '', 
        password: '', 
        status: '', 
        address: '', 
        country: '', 
        city: '', 
        dpLink: '', 
        thirdPartyToken: '', 
        authProvider: '', 
        location: '', 
        newsLetter: '', 
        lastLoginDate: null, 
        lastModifiedDate: null,
  );

  User get user => _user;
  User getFullUserData() => _user;

  void setUser(String jsonResponse) {
  try {
    final Map<String, dynamic> jsonData = jsonDecode(jsonResponse);

    if (jsonData.containsKey('user')) {
      final Map<String, dynamic> userData = jsonData['user'];
      _user = User.fromMap(userData);
      notifyListeners();
    } else {
      throw ArgumentError('Invalid JSON structure: "user" key not found');
    }
  } catch (e) {
    rethrow; // Re-throw the error to propagate it further if needed
  }
}

  // void setUserFromModel(User user) {
  //   _user = user;
  //   notifyListeners();
  // }

    Future<void> saveUserToSharedPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String userJson = jsonEncode(_user.toMap());
      await prefs.setString('user_data', userJson);
    } catch (e) {
      print('Error saving user data to SharedPreferences: $e');
    }
  }


   Future<void> loadUserFromSharedPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userJson = prefs.getString('user_data');

      if (userJson != null) {
        final Map<String, dynamic> userData = jsonDecode(userJson);
        _user = User.fromMap(userData);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user data from SharedPreferences: $e');
    }
  }

  Future<bool> get isLoggedIn async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    return token != null && token.isNotEmpty;
  }
  

  Future<void> logout() async {
    try {
      // Clear user data from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_data');
      // Clear the user object
      _user = User(
        id: null, 
        role: '', 
        uuid: '', 
        name: '', 
        businessName: '',
        businessEmail: '', 
        businessMobile: '', 
        businessAddress: '', 
        businessCacLink: '', 
        businessNepcLink: '', 
        description: '', 
        handle: '',
        idType: '', 
        idLink: '', 
        personalEmail: '', 
        email: '', 
        isVerified: '', 
        isSubscribed: '', 
        isEnabled: false, 
        gender: '', 
        kycLevel: null, 
        categoryId: '', 
        accountType: '',
        mobile: '', 
        preferredCurrency: '', 
        password: '', 
        status: '', 
        address: '', 
        country: '', 
        city: '', 
        dpLink: '', 
        thirdPartyToken: '', 
        authProvider: '', 
        location: '', 
        newsLetter: '', 
        lastLoginDate: null, 
        lastModifiedDate: null,
        // ... set all other properties to default values or empty strings
      );
    notifyListeners();
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
