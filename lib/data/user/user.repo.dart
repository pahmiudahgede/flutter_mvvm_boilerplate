import 'package:fluttercomponentui/data/user/user.model.dart';
import 'package:fluttercomponentui/data/user/user.service.dart';

class UserRepository {
  final UserService _userService;

  UserRepository(this._userService);

  Future<List<User>> getAllUsers() async {
    try {
      final response = await _userService.getAllUsers();
      return response.data;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      final response = await _userService.getUserById(id);
      return response.data.isNotEmpty ? response.data.first : null;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  Future<int> getUserCount() async {
    try {
      return await _userService.getUserCount();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}