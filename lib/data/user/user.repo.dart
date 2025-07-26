import 'package:fluttercomponentui/data/user/user.model.dart';
import 'package:fluttercomponentui/data/user/user.service.dart';

class UserRepository {
  final UserService _userService;

  UserRepository(this._userService);

  // READ OPERATIONS
  Future<List<User>> getAllUsers() async {
    try {
      final response = await _userService.getAllUsers();
      if (response.isError) {
        throw Exception(response.meta.message);
      }
      return response.data;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      final response = await _userService.getUserById(id);
      if (response.isError) {
        throw Exception(response.meta.message);
      }
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

  // CREATE OPERATION
  Future<User> createUser({
    required String name,
    required String gender,
    required String dateOfBirth,
    required String placeOfBirth,
    required String address,
    required String email,
    required String password,
    String? avatar,
  }) async {
    try {
      final response = await _userService.createUser(
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        placeOfBirth: placeOfBirth,
        address: address,
        email: email,
        password: password,
        avatar: avatar,
      );
      
      if (response.isError) {
        throw Exception(response.meta.message);
      }
      
      return response.data.first;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  // UPDATE OPERATION
  Future<User> updateUser({
    required String id,
    String? name,
    String? gender,
    String? dateOfBirth,
    String? placeOfBirth,
    String? address,
    String? email,
    String? password,
    String? avatar,
  }) async {
    try {
      final response = await _userService.updateUser(
        id: id,
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        placeOfBirth: placeOfBirth,
        address: address,
        email: email,
        password: password,
        avatar: avatar,
      );
      
      if (response.isError) {
        throw Exception(response.meta.message);
      }
      
      return response.data.first;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  // DELETE OPERATION
  Future<bool> deleteUser(String id) async {
    try {
      final response = await _userService.deleteUser(id);
      
      if (response.isError) {
        throw Exception(response.meta.message);
      }
      
      return true;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}