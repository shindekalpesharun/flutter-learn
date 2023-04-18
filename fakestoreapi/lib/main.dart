import 'package:fakestoreapi/data/provider/CartProviderModel.dart';
import 'package:fakestoreapi/presentation/HomeScreen.dart';
import 'package:fakestoreapi/presentation/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProviderModel>(
            create: (context) => CartProviderModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // useMaterial3: true,
      ),
      home: const LoginScreen(),
      // debugShowCheckedModeBanner: false,
    );
  }
}
//
// class HomePageScreen extends StatefulWidget {
//   const HomePageScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomePageScreen> createState() => _HomePageScreenState();
// }
//
// class _HomePageScreenState extends State<HomePageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }
