import 'package:fluttercomponentui/core/apiclient.dart';
import 'package:fluttercomponentui/data/user/user.model.dart';

class UserService {
  
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
}