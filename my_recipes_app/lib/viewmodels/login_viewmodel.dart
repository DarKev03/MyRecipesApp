import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/User.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  User? _currentUser;

  User? get currentUser => _currentUser;

  LoginViewModel({required UserRepository userRepository})
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

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
