import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/User.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';

class SignUpViewModel extends ChangeNotifier {
  final UserRepository _userRepository;  

  SignUpViewModel({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<bool> signUp(User user) async {
    try {
      await _userRepository.createUser(user);      
      return true;
    } catch (e) {
      return false;
    }
  }
    
}
