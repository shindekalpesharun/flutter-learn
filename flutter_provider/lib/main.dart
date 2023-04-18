import 'package:flutter/material.dart';
import 'package:flutter_provider/CountModel.dart';
import 'package:flutter_provider/ThemeModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Working code for single provider
    // ChangeNotifierProvider(
    //   create: (_) => CountModel(),
    //   child: const MyApp(),
    // ),
    // This code for multiple provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CountModel>(create: (context) => CountModel()),
        ChangeNotifierProvider<ThemeModel>(create: (context) => ThemeModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeModel>(context).getTheme(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("${Provider.of<CountModel>(context).count}"),
        // child: Consumer<CountModel>(
        //   builder: (context, data, child) {
        //     return Text(
        //       '${data.count}',
        //       style: Theme.of(context).textTheme.headlineMedium,
        //     );
        //   },
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Provider.of<ThemeModel>(context, listen: false).setDarkTheme();
          Provider.of<CountModel>(context, listen: false).add();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
