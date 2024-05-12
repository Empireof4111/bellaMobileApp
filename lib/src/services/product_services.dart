// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:bella_banga/core/error_handling.dart';
import 'package:bella_banga/src/model/categoryModel.dart';
import 'package:bella_banga/src/model/productModel.dart';
import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductServices{

//FETCHING ALL PRODUCT

Future<List<Product>> fetchAllUserProducts(BuildContext context, int page, int size) async {
    List<Product> userProductList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$basedUrl/api/product/get_all?page=$page&size=$size'), 
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['payload']['content'].length; i++) {
              userProductList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)['payload']['content'][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      print(e);
    }
    return userProductList;
  }

  Future<List<Product>> searchProducts(BuildContext context, int page, int size, String searchQuery) async {
    List<Product> searchProductList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$basedUrl/api/product/search?q=$searchQuery&status=AC&page=$page&size=$size'), 
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['payload']['content'].length; i++) {
              searchProductList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)['payload']['content'][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      print(e);
    }
    return searchProductList;
  }

//FETCHING ALL BY CATEGORY ID
Future<List<Product>> fetchAllProductsByCategory(BuildContext context, int categoryId, int page, int size) async {
    List<Product> userProductList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$basedUrl/api/product/get_by_category_id/$categoryId?page=$page&size=$size'), 
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['payload']['content'].length; i++) {
              userProductList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)['payload']['content'][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      print(e);
    }
    return userProductList;
  }

//FETCH ALL PRODUCT BY VENDOR ID
  Future<List<Product>> fetchAllProductsByVendorId(BuildContext context, int vendorId, int page, int size) async {
    List<Product> vendorProductList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$basedUrl/api/product/get_all_by_vendor/$vendorId?page=$page&size=$size'), 
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['payload']['content'].length; i++) {
              vendorProductList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)['payload']['content'][i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      print(e);
    }
    return vendorProductList;
  }

//FETCHING ALL CATEGORY

Future<List<CategoryModel>> fetchAllCategory(BuildContext context) async {
    List<CategoryModel> productCategoryList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$basedUrl/api/category/get_all_active'), 
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['payload'].length; i++) {
              productCategoryList.add(
                CategoryModel.fromJson(
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
    return productCategoryList;
  }


//FETCHING CATEGORY BY ID

Future<List<CategoryModel>> fetchProductCategoryById(BuildContext context, int id) async {
    List<CategoryModel> productCategoryById = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$basedUrl/api/category/get_by_id/$id'), 
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
              productCategoryById.add(
                CategoryModel.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)['payload'],
                  ),
                ),
              );
          });
    } catch (e) {
      print(e);
    }
    return productCategoryById;
  }



  Future<List<String>?> fetchReviewData(int id) async {
    List <String>? reviewList;
    final response = await http.get(Uri.parse('$basedUrl/api/review/get_by_product_id/$id'));
    print(response.body);
    final Map<String, dynamic> data = json.decode(response.body);
      if(data['success']){
        reviewList = data['payload'];
        return reviewList;
      }else{
        return [];
      }
  }
}