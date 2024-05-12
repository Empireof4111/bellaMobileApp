// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bella_banga/src/model/whishlistModel.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistSerives {

   
   Future<http.Response> addWishList(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
   http.Response res = await http.post(Uri.parse("$basedUrl/api/wishlist/add/$productId"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    }
    );
      return res;
  }


  Future<http.Response> deleteWhishlist (int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    http.Response res = await http.delete(Uri.parse("$basedUrl/api/wishlist/delete/$id"),
     headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    }
    );

    return res; 
  }


  
  Future<http.Response> deleteAllWhishlist () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    http.Response res = await http.delete(Uri.parse("$basedUrl/api/wishlist/delete-all"),
     headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    }
    );

    return res; 
  }



  Future<List<WishListModel>> userWishList(BuildContext context, int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    List<WishListModel> userWishList = [];
    try {
      http.Response res = await http.get(Uri.parse("$basedUrl/api/wishlist/get_by_user/$userId"),
     headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
     }
      );
       if(jsonDecode(res.body)['success']){
        for(int x = 0; x < jsonDecode(res.body)['payload'].length; x++){
            userWishList.add(
              WishListModel.fromJson(
                jsonEncode ( jsonDecode(res.body)['payload'][x])
                  
              )
            );
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userWishList;
    }


}
