import 'package:flutter/material.dart';

class CountModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void add() {
    _count++;
    notifyListeners();
  }

  void remove() {
    _count = 0;
    notifyListeners();
  }
}
