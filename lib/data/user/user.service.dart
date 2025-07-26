import 'package:fluttercomponentui/core/apiclient.dart';
import 'package:fluttercomponentui/data/user/user.model.dart';

class UserService {
  
  // READ OPERATIONS
  Future<ApiResponse<User>> getAllUsers() async {
    try {
      final response = await ApiClient.get('', params: {
        'action': 'getAll',
      });
      
      return ApiResponse.fromJson(response, (json) => User.fromJson(json));
    } catch (e) {
      throw Exception('Failed to get users: $e');
    }
  }

  Future<ApiResponse<User>> getUserById(String id) async {
    try {
      final response = await ApiClient.get('', params: {
        'action': 'getById',
        'id': id,
      });
      
      return ApiResponse.fromJson(response, (json) => User.fromJson(json));
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<int> getUserCount() async {
    try {
      final response = await ApiClient.get('', params: {
        'action': 'count',
      });
      
      final apiResponse = ApiResponse.fromJson(response, (json) => json);
      
      if (apiResponse.data.isNotEmpty) {
        return apiResponse.data.first['count'] ?? 0;
      }
      
      return 0;
    } catch (e) {
      throw Exception('Failed to get user count: $e');
    }
  }

  // CREATE OPERATION
  Future<ApiResponse<User>> createUser({
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
      // Create user with auto-generated fields
      final newUser = User.createNew(
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        placeOfBirth: placeOfBirth,
        address: address,
        email: email,
        password: password,
        avatar: avatar,
      );

      final response = await ApiClient.post({
        'action': 'create',
        'data': newUser.toJson(),
      });
      
      return ApiResponse.fromJson(response, (json) => User.fromJson(json));
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // UPDATE OPERATION
  Future<ApiResponse<User>> updateUser({
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
      // Create update data with only changed fields
      final updateData = User(
        id: id,
        name: '',
        gender: '',
        dateOfBirth: '',
        placeOfBirth: '',
        address: '',
        email: '',
        password: '',
        avatar: '',
        createdAt: '',
        updatedAt: '',
      ).toUpdateJson(
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        placeOfBirth: placeOfBirth,
        address: address,
        email: email,
        password: password,
        avatar: avatar,
      );

      final response = await ApiClient.post({
        'action': 'update',
        'id': id,
        'data': updateData,
      });
      
      return ApiResponse.fromJson(response, (json) => User.fromJson(json));
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // DELETE OPERATION
  Future<ApiResponse<Map<String, dynamic>>> deleteUser(String id) async {
    try {
      final response = await ApiClient.post({
        'action': 'delete',
        'id': id,
      });
      
      return ApiResponse.fromJson(response, (json) => json);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}