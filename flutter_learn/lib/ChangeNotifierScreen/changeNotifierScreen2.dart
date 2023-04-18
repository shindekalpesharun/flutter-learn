import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifierScreen2 extends StatefulWidget {
  const ChangeNotifierScreen2({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierScreen2> createState() => _ChangeNotifierScreen2State();
}

class _ChangeNotifierScreen2State extends State<ChangeNotifierScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Consumer<MyModel>(builder: (context, myModel, child) {
            return Column(
              children: [
                Text(myModel.someValue),
                TextButton(
                  onPressed: () {
                    myModel.doSomething();
                  },
                  child: Text("change value"),
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}

class MyModel extends ChangeNotifier {
  int num = 1;
  String someValue = 'Hello';
  void doSomething() {
    num++;
    someValue = 'Goodbye' + num.toString();
    print("change values ----" + num.toString());
    notifyListeners();
  }
}
