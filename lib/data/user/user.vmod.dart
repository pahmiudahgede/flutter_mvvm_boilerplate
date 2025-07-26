import 'package:flutter/material.dart';
import 'package:fluttercomponentui/data/user/user.model.dart';
import 'package:fluttercomponentui/data/user/user.repo.dart';

enum UserState { idle, loading, success, error }

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  UserViewModel(this._userRepository);

  UserState _state = UserState.idle;
  UserState get state => _state;

  List<User> _users = [];
  List<User> get users => _users;

  User? _selectedUser;
  User? get selectedUser => _selectedUser;

  int _userCount = 0;
  int get userCount => _userCount;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool get isLoading => _state == UserState.loading;
  bool get hasError => _state == UserState.error;
  bool get isSuccess => _state == UserState.success;

  void _setState(UserState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setState(UserState.error);
  }

  // READ OPERATIONS
  Future<void> getAllUsers() async {
    _setState(UserState.loading);
    
    try {
      _users = await _userRepository.getAllUsers();
      _setState(UserState.success);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> getUserById(String id) async {
    _setState(UserState.loading);
    
    try {
      _selectedUser = await _userRepository.getUserById(id);
      _setState(UserState.success);
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> getUserCount() async {
    _setState(UserState.loading);
    
    try {
      _userCount = await _userRepository.getUserCount();
      _setState(UserState.success);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // CREATE OPERATION
  Future<bool> createUser({
    required String name,
    required String gender,
    required String dateOfBirth,
    required String placeOfBirth,
    required String address,
    required String email,
    required String password,
    String? avatar,
  }) async {
    _setState(UserState.loading);
    
    try {
      final newUser = await _userRepository.createUser(
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        placeOfBirth: placeOfBirth,
        address: address,
        email: email,
        password: password,
        avatar: avatar,
      );
      
      // Add to local list to update UI immediately
      _users.add(newUser);
      _userCount++;
      
      _setState(UserState.success);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // UPDATE OPERATION
  Future<bool> updateUser({
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
    _setState(UserState.loading);
    
    try {
      final updatedUser = await _userRepository.updateUser(
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
      
      // Update local list
      final index = _users.indexWhere((user) => user.id == id);
      if (index != -1) {
        _users[index] = updatedUser;
      }
      
      // Update selected user if it's the same
      if (_selectedUser?.id == id) {
        _selectedUser = updatedUser;
      }
      
      _setState(UserState.success);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // DELETE OPERATION
  Future<bool> deleteUser(String id) async {
    _setState(UserState.loading);
    
    try {
      await _userRepository.deleteUser(id);
      
      // Remove from local list
      _users.removeWhere((user) => user.id == id);
      _userCount--;
      
      // Clear selected user if it's the deleted one
      if (_selectedUser?.id == id) {
        _selectedUser = null;
      }
      
      _setState(UserState.success);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // UTILITY METHODS
  void clearError() {
    _errorMessage = '';
    _setState(UserState.idle);
  }

  void clearSelectedUser() {
    _selectedUser = null;
    notifyListeners();
  }

  void refreshUsers() {
    getAllUsers();
  }

  // Search functionality
  List<User> searchUsers(String query) {
    if (query.isEmpty) return _users;
    
    final lowerQuery = query.toLowerCase();
    return _users.where((user) {
      return user.name.toLowerCase().contains(lowerQuery) ||
             user.email.toLowerCase().contains(lowerQuery) ||
             user.address.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}