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

  void _setState(UserState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setState(UserState.error);
  }

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

  void clearError() {
    _errorMessage = '';
    _setState(UserState.idle);
  }

  void clearSelectedUser() {
    _selectedUser = null;
    notifyListeners();
  }
}