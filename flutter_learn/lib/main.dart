import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/APICallScreens/DioScreen/DioScreen1.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/CommentScreen.dart';
import 'package:flutter_learn/APICallScreens/HTTPScreens/UserScreens.dart';
import 'package:flutter_learn/firebaseScreen/FirestoreScreen.dart';
import 'package:flutter_learn/animationScreen/animationScreen.dart';
import 'package:flutter_learn/getXScreen/GetXScreen1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: FireStoreScreen(),
      // home: UserScreens(),
      // home: CommentScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: GetXScreen1(),
      home: DioScreen(),
      // home: AnimationScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.green,
          onPrimary: Colors.green,
          secondary: Colors.red,
          onSecondary: Colors.red,
          error: Colors.red,
          onError: Colors.red,
          background: Colors.green,
          onBackground: Colors.green,
          surface: Colors.red,
          onSurface: Colors.white,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
    );
  }
}
