import 'package:flutter/material.dart';
import 'package:flutter_learn/ChangeNotifierScreen/nameNotifier.dart';
import 'package:provider/provider.dart';

class changeNotifierScreen1 extends StatefulWidget {
  const changeNotifierScreen1({Key? key}) : super(key: key);

  @override
  State<changeNotifierScreen1> createState() => _changeNotifierScreen1State();
}

class _changeNotifierScreen1State extends State<changeNotifierScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            onChanged: (val) {
              print(val);
              Provider.of<MyName>(context, listen: false).changeName(val);
            },
          ),
        ],
      ),
    );
  }
}
