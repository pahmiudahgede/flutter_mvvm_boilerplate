
import 'package:fluttercomponentui/data/user/user.model.dart';
import 'package:fluttercomponentui/screen/user.screen.dart';
import 'package:fluttercomponentui/screen/userdetail.screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const UserScreen(),
    ),
    GoRoute(
      path: '/user-detail',
      builder: (context, state) {
        final user = state.extra as User;
        return UserDetailScreen(user: user);
      },
    ),
  ],
);