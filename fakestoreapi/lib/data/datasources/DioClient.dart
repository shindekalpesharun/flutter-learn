import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fakestoreapi/data/models/AllProductModel.dart';
import 'package:fakestoreapi/data/models/GetSingleProductModel.dart';
import 'package:fakestoreapi/data/models/UserLoginModel.dart';
import 'package:fakestoreapi/data/models/UsersTestModel.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = "https://fakestoreapi.com";

  Future<UserLoginModel?> login() async {
    UserLoginModel? user;
    try {
      Response userData = await _dio.post(
        '$_baseUrl/auth/login',
        data: {'username': "mor_2314", 'password': "83r5^_"},
      );
      print('User Info: ${userData.data}');
      user = UserLoginModel.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }

  Future getCategory() async {
    // CategoriesModel? category;
    var category;
    try {
      Response categoryData = await _dio.get(
        '$_baseUrl/products/categories',
      );
      print('User Info:-------------------------------- ${categoryData.data}');
      category = List<String>.from(categoryData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return category;
  }

  Future<List<AllProductModel>> getAllProduct() async {
    List<AllProductModel>? allProductModel;
    try {
      Response response = await _dio.get(
        '$_baseUrl/products',
      );
      print('User Info: ${response.data}');
      //For the list response
      return (response.data as List)
          .map((x) => AllProductModel.fromJson(x))
          .toList();
      // allProductModel = List<AllProductModel>.from(
      //     json.decode(response.data).map((x) => AllProductModel.fromJson(x)));
      // allProductModel = List<AllProductModel>.fromJson(jsonDecode(response.data));
      //allProductModel = AllProductModel.fromJson(response.data);
      // List<AllProductModel>.from(
      //     json.decode(response.data).map((x) => AllProductModel.fromJson(x)));
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return [];
  }

  Future<GetSingleProductModel?> getSingleProduct(int id) async {
    GetSingleProductModel? user;
    try {
      Response userData = await _dio.get(
        '$_baseUrl/products/$id',
      );
      print('User Info: ${userData.data}');
      user = GetSingleProductModel.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }
}
