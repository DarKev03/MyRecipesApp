import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/user.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  User? _currentUser;

  User? get currentUser => _currentUser;

  UserViewModel({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<bool> login(User user) async {
    try {
      final loggedInUser = await _userRepository.loginUser(user);
      setCurrentUser(loggedInUser);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<bool> signUp(User user) async {
    try {
      await _userRepository.registerUser(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      await _userRepository.updateUser(user);
      setCurrentUser(user);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(int userId) async {
    try {
      await _userRepository.deleteUser(userId);
      if (_currentUser?.id == userId) {
        logout();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
