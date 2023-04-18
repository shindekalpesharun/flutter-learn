import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talktron/screens/chat_list_screen.dart';
import 'package:talktron/screens/chat_screen.dart';
import 'package:talktron/screens/login_screen.dart';
import 'package:talktron/screens/profile_page.dart';
import 'package:talktron/providers/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'chatlist',
          builder: (BuildContext context, GoRouterState state) {
            return const ChatListScreen();
          },
        ),
        GoRoute(
          path: 'chat/:userId/:id2',
          name: 'chat',
          builder: (BuildContext context, GoRouterState state) {
            return ChatScreen(
              userId: state.params['userId'] ?? "",
              id2: state.params['id2'] ?? "",
            );
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const LoginScreen(),
      //   '/chat_list_screen': (context) => const ChatListScreen(),
      //   '/chat_screen': (context) => const ChatScreen(),
      //   '/profile': (context) => const ProfileScreen(),
      // },
    );
  }
}

// final _router = GoRouter(
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => LoginScreen()),
//     GoRoute(path: '/chat_list_screen', builder: (context, state) => ChatListScreen()),
//     GoRoute(path: '/chat_screen', builder: (context, state) => ChatScreen()),
//     GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
//   ],
// );
