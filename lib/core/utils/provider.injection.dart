import 'package:get_it/get_it.dart';
import 'package:fluttercomponentui/data/user/user.service.dart';
import 'package:fluttercomponentui/data/user/user.repo.dart';
import 'package:fluttercomponentui/data/user/user.vmod.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<UserService>(() => UserService());
  sl.registerLazySingleton<UserRepository>(() => UserRepository(sl()));
  sl.registerFactory<UserViewModel>(() => UserViewModel(sl()));
}