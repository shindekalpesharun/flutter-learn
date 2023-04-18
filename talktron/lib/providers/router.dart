import 'package:go_router/go_router.dart';
import 'package:talktron/screens/login_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
  ],
);