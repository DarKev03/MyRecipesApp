import 'package:my_recipes_app/data/models/user.dart';
import 'package:my_recipes_app/data/services/user_service.dart';

class UserRepository {
  Future<User> registerUser(User user) async {
    return await UserService().registerUser(user);
  }

  Future<User> updateUser(User user) async {
    return await UserService().updateUser(user);
  }

  Future<void> deleteUser(String userId) async {
    return await UserService().deleteUser(userId);
  }

  Future<List<User>> getAllUsers() async {
    return await UserService().getAllUsers();
  }

  Future<User> getUserById(String userId) async {
    return await UserService().getUserById(userId);
  }

  Future<User> loginUser(User user) async {
    return await UserService().loginUser(user);
  }
}
