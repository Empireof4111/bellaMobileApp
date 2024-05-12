// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:bella_banga/core/error_handling.dart';
import 'package:bella_banga/src/model/userModel.dart';
import 'package:bella_banga/src/model/vendorModel.dart';
import 'package:bella_banga/src/provider/user_provider.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:bella_banga/src/view/screen/checkout_screen.dart';
import 'package:bella_banga/src/view/screen/home_screen.dart';
import 'package:bella_banga/src/view/screen/login_screen.dart';
import 'package:bella_banga/src/view/screen/otp_screen.dart';
import 'package:bella_banga/src/view/screen/profile_screen.dart';
import 'package:bella_banga/src/view/screen/update_password_otp.dart';
import 'package:bella_banga/src/view/screen/update_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
//crreating the sign uo function

  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String country,
    required String city,
  }) async {
    try {
      User user = User(
        id: null,
        role: null,
        uuid: null,
        name: name,
        businessName: null,
        businessEmail: null,
        businessMobile: null,
        businessAddress: null,
        businessCacLink: null,
        businessNepcLink: null,
        description: null,
        handle: null,
        idType: null,
        idLink: null,
        personalEmail: null,
        email: email,
        isVerified: null,
        isSubscribed: null,
        isEnabled: null,
        gender: null,
        kycLevel: null,
        categoryId: null,
        accountType: null,
        mobile: phoneNumber,
        preferredCurrency: null,
        password: password,
        status: null,
        address: null,
        country: country,
        city: city,
        dpLink: null,
        thirdPartyToken: null,
        authProvider: null,
        location: null,
        newsLetter: null,
        lastLoginDate: null,
        lastModifiedDate: null,
      );
      http.Response res = await http.post(
        Uri.parse('$basedUrl/api/user/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          if (jsonDecode(res.body)['success']) {
            showSnackBar(context, jsonDecode(res.body)['message']);
            String mailToVerify = (res.body);
            var outPut = jsonDecode(mailToVerify);
            Navigator.pushNamed(
              context,
              OtpScreen.routeName,
              arguments: outPut['payload']['email']!,
            );
          } else {
            showSnackBar(context, jsonDecode(res.body)['message']);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //crreating the sign user function
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required String firstLogin,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$basedUrl/api/user/signin'),
        body: jsonEncode({
          "username": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          if (jsonDecode(res.body)['success']) {
            showSnackBar(context, jsonDecode(res.body)['message']);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser((res.body));
            await Provider.of<UserProvider>(context, listen: false)
                .saveUserToSharedPreferences();
            prefs.setString('Bearer', jsonDecode(res.body)['bearer']);
            if (firstLogin == 'isAcountVerified') {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            } else if (firstLogin == "checkOut") {
              Navigator.pushNamed(
                context,
                CheckoutScreen.routeName,
              );
            } else if (firstLogin == 'fromProfile') {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
              // Navigator.pushNamedAndRemoveUntil(
              //     context, ProfileScreen.routeName, (route) => false);
            } else {
              Navigator.pop(context);
            }
          } else {
            showSnackBar(context, jsonDecode(res.body)['message']);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signOutUser(BuildContext context) async {
    try {
      // Retrieve the existing instance of UserProvider
      UserProvider userProvider = UserProvider();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('Bearer');
      userProvider.logout();
      Navigator.restorablePushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//Verify Account
  void verifyUser({
    required BuildContext context,
    required String email,
    required String otp,
    required String toScreen,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$basedUrl/api/user/verify'),
        body: jsonEncode({
          "username": email,
          "otp": otp,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, jsonDecode(res.body)['message']);
          if (toScreen == 'signUp') {
            Navigator.pushNamed(context, LoginScreen.routeName,
                arguments: "isAcountVerified");
          } else if (toScreen == 'forgotPass') {
            Navigator.pushNamed(context, UpdatePasswordScreen.routName,
                arguments: email);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//Reset Password route
  void updatePassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    try {
      http.Response res = await http.post(
        Uri.parse(
            '$basedUrl/api/user/password-reset'), //api/user/password-reset
        body: jsonEncode({
          "username": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, "Password Reset Successiful");
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void changePassword({
    required BuildContext context,
    required String oldpassword,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    try {
      http.Response res = await http.post(
        Uri.parse('$basedUrl/api/user/change-password'),
        body: jsonEncode({
          "oldPassword": oldpassword,
          "newPassword": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, "Password Change Successiful");
          Navigator.pushNamed(context, ProfileScreen.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void editProfile({
    required BuildContext context,
    required String id,
    required String name,
    required String phone,
    required String email,
    required String dpLink,
    required String country,
    required String city,
    required String address,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    try {
      http.Response res = await http.put(
        Uri.parse('$basedUrl/api/user/profile-update/$id'),
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "email": email,
          "dpLink": dpLink,
          "country": country,
          "city": city,
          "address": address,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, "Profile Update Successiful");
          Navigator.pushNamed(context, ProfileScreen.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//Forgot password
  void regenarateOtp({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$basedUrl/api/user/generate-otp'),
        body: jsonEncode({
          "username": email,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          if (jsonDecode(res.body)['success']) {
            Navigator.pushNamed(context, UpdatePasswordOtp.routeName,
                arguments: email);
            showSnackBar(context, jsonDecode(res.body)['payload']);
          } else {
            showSnackBar(context, jsonDecode(res.body)['message']);
          }
        },
      );
    } catch (e) {
      // print(e);
      showSnackBar(context, e.toString());
    }
  }

  //VENDOR SERVICES
  Future<List<VendorModel>> fetchAllVendors(
      BuildContext context, int page, int size) async {
    List<VendorModel> vendorList = [];
    try {
      http.Response res = await http.get(
          Uri.parse(
              '$basedUrl/api/user/get_by_role?role=VENDOR&status=AC&page=$page&size=$size'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0;
                i < jsonDecode(res.body)['payload']['content'].length;
                i++) {
              vendorList.add(
                VendorModel.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)['payload']['content'][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      // showSnackBar(context, e.toString());
      print(e);
    }
    return vendorList;
  }
}
