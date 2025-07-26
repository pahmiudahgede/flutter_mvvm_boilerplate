import 'package:fluttercomponentui/screen/adduser.screen.dart';
import 'package:fluttercomponentui/data/user/user.model.dart';
import 'package:fluttercomponentui/screen/edituser.screen.dart';
import 'package:fluttercomponentui/screen/user.screen.dart';
import 'package:fluttercomponentui/screen/userdetail.screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const UserScreen()),
    GoRoute(
      path: '/add-user',
      builder: (context, state) => const AddUserScreen(),
    ),
    GoRoute(
      path: '/user-detail',
      builder: (context, state) {
        final user = state.extra as User;
        return UserDetailScreen(user: user);
      },
    ),
    GoRoute(
      path: '/edit-user',
      builder: (context, state) {
        final user = state.extra as User;
        return EditUserScreen(user: user);
      },
    ),
  ],
);
