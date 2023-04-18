import 'package:flutter/cupertino.dart';

class MyName extends ChangeNotifier {
  String? name = "Jayesh";

  void changeName(String name1) {
    name = name1;
    notifyListeners();
  }
}
