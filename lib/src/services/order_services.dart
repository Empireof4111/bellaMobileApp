// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:bella_banga/core/error_handling.dart';
import 'package:bella_banga/src/model/orderDetailModel.dart';
import 'package:bella_banga/src/model/orderModel.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderServices {
//PLACE ORDER
  static Future<http.Response> placeOrder(orderDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    print((orderDetails));
    return await http.post(
      Uri.parse('$basedUrl/api/order/add'),
      body: jsonEncode(orderDetails), // Use jsonEncode to convert Map to JSON
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }

// CANCELLED ORDER
  static Future<http.Response> cancelledOrder(int orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    return await http.put(Uri.parse('$basedUrl/api/order/cancel/$orderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
  }

  Future<List<OrderModel>> getOrderByUserId(
      BuildContext context, int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    List<OrderModel> orderList = [];
    try {
      http.Response res = await http.get(
          Uri.parse("$basedUrl/api/order/get_by_customer/$userId"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['payload'].length; i++) {
              orderList.add(
                OrderModel.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)['payload'][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      print(e);
    }
    return orderList;
  }

  Future<List<OrderModel>> getOrderByOrderId(
      BuildContext context, int orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    List<OrderModel> orderListById = [];
    try {
      http.Response res = await http.get(
          Uri.parse("$basedUrl/api/order/get_by_id/$orderId"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            orderListById.add(
              OrderModel.fromJson(jsonEncode(jsonDecode(res.body)['payload'])),
            );
          });
    } catch (e) {
      print(e);
    }
    return orderListById;
  }

  Future<List<OrderDetailModel>> orderDetail(
      BuildContext context, int orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Bearer');
    List<OrderDetailModel> orderDetailList = [];
    try {
      http.Response res = await http.get(
          Uri.parse("$basedUrl/api/order/get_details_by_id/$orderId"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['payload'].length; i++) {
              orderDetailList.add(
                OrderDetailModel.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)['payload'][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      print(e);
    }
    return orderDetailList;
  }
}
