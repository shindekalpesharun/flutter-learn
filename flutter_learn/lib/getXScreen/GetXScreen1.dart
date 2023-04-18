import 'package:flutter/material.dart';
import 'package:flutter_learn/getXScreen/model/Counter.dart';
import 'package:get/get.dart';

//https://github.com/jonataslaw/getx/blob/master/README.md

class GetXScreen1 extends StatelessWidget {
  GetXScreen1({Key? key}) : super(key: key);
  final CounterController counter = Get.put(CounterController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Obx(
              () => Text(
            counter.count.toString(),
          ),
        ),
        TextButton(
          onPressed: () {
            counter.increment();
            Get.isSnackbarOpen;
          },
          child: Text('add'),
        ),
        TextButton(
          onPressed: () {
            Get.changeTheme(Get.isDarkMode? ThemeData.light(): ThemeData.dark());
          },
          child: Text('change theme'),
        )
      ]),
    );
  }
}


class OtherPage extends StatefulWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
