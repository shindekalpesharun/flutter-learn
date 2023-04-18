import 'package:flutter/material.dart';
import 'package:flutter_learn/ChangeNotifierScreen/changeNotifierScreen1.dart';
import 'package:flutter_learn/ChangeNotifierScreen/counterNotifier.dart';
import 'package:flutter_learn/ChangeNotifierScreen/nameNotifier.dart';
import 'package:provider/provider.dart';

class changeNotifierScreen extends StatefulWidget {
  const changeNotifierScreen({Key? key}) : super(key: key);

  @override
  State<changeNotifierScreen> createState() => _changeNotifierScreenState();
}

class _changeNotifierScreenState extends State<changeNotifierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        OutlinedButton(
            onPressed: () {
              Provider.of<Counter>(context, listen: false).add();
            },
            child: const Text("+")),
        OutlinedButton(
            onPressed: () {
              Provider.of<Counter>(context, listen: false).remove();
            },
            child: const Text("-")),
        Consumer<Counter>(builder: (_, val, child) {
          return Text(val.currNumber.toString());
        }),
        MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => changeNotifierScreen1()));
          },
          child: const Text("next page"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Text(context.watch<MyName>().name ?? ""),
      ]),
    );
  }
}
