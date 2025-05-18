import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/User.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';
import 'package:my_recipes_app/ui/pages/auth/login_page.dart';
import 'package:my_recipes_app/ui/pages/main/home_page.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_scaffold_messenger.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_buttom.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/sign_up_viewmodel.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final UserRepository userRepository = UserRepository();
  final SignUpViewModel signUpViewModel =
      SignUpViewModel(userRepository: UserRepository());
  SignUpPage({super.key});

  bool isValid(BuildContext context) {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (!Validations.isValidName(name) ||
        !Validations.isValidEmail(email) ||
        !Validations.isValidPassword(password) ||
        !Validations.doPasswordsMatch(password, confirmPassword)) {
      if (!Validations.isValidName(name)) {
        CustomSnackbar.show(context, "Please fill in all fields");
      } else if (!Validations.isValidEmail(email)) {
        CustomSnackbar.show(context, "Invalid email format");
      } else if (!Validations.isValidPassword(password)) {
        CustomSnackbar.show(context,
            "Password must be at least 7 characters long and contain at least one uppercase letter and one number");
      } else if (!Validations.doPasswordsMatch(password, confirmPassword)) {
        CustomSnackbar.show(context, "Passwords do not match");
      }

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120),

                // Nombre de la pagina
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),

                const SizedBox(height: 15),

                // Subtitulo
                const Text(
                  'Create your new account',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryColor,
                  ),
                ),

                const SizedBox(height: 30),

                // Formularios de registro
                CustomTextField(
                  controller: nameController,
                  isPassword: false,
                  labelText: 'Name',
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: emailController,
                  isPassword: false,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  isPassword: true,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  isPassword: true,
                ),

                const SizedBox(height: 30),

                // Sign up button
                CustomElevatedButtomWidget(
                  width: 120,
                  text: "Sign up",
                  onPressed: () async {
                    try {
                      if (!isValid(context)) {
                        return;
                      }
                      bool success = await signUpViewModel.signUp(User(
                          id: null,
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          createdAt: null,
                          isAdmin: null));
                      if (success) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      } else {
                        CustomSnackbar.show(
                          context,
                          "You can't cross this bridge",
                        );
                      }
                    } catch (e) {}
                  },
                ),

                const SizedBox(height: 5),

                // Login
                CustomTextButtom(
                  textSize: 13,
                  text: "Already have an account?",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),

                Text("Or continue with"),

                const SizedBox(height: 5),

                // Boton de google
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "lib/assets/images/google_png.webp",
                      width: 50,
                      height: 50,
                    )),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
