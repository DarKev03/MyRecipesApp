import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/user.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';

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
