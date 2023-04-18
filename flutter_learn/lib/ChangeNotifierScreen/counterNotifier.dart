import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier {
  int currNumber = 0;

  void add() {
    currNumber++;
    notifyListeners();
  }

  void remove() {
    currNumber > 1 ? currNumber-- : null;
    notifyListeners();
  }
}
