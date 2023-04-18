import 'package:fakestoreapi/data/datasources/DioClient.dart';
import 'package:fakestoreapi/data/models/AllProductModel.dart';
import 'package:flutter/material.dart';

class CartProviderModel extends ChangeNotifier {
  List<AllProductModel> allProductModel = [];

  int get allProductModelCount => allProductModel.length;

  void addToCart(int id) {
    notifyListeners();
  }

  void removeToCart(int id) {
    allProductModel.removeAt(id);
    // allProductModel.clear();
    notifyListeners();
  }
}
