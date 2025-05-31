import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/user.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';
import 'package:my_recipes_app/ui/pages/auth/login_page.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_scaffold_messenger.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_buttom.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/navbar.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final UserRepository userRepository = UserRepository();
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
        CustomSnackbar.show(
            context, AppLocalizations.of(context)!.fillAllFields);
      } else if (!Validations.isValidEmail(email)) {
        CustomSnackbar.show(
            context, AppLocalizations.of(context)!.invalidEmailFormat);
      } else if (!Validations.isValidPassword(password)) {
        CustomSnackbar.show(
            context, AppLocalizations.of(context)!.passwordRequirements);
      } else if (!Validations.doPasswordsMatch(password, confirmPassword)) {
        CustomSnackbar.show(
            context, AppLocalizations.of(context)!.passwordsDoNotMatch);
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
                Text(
                  AppLocalizations.of(context)!.register,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),

                const SizedBox(height: 15),

                // Subtitulo
                Text(
                  AppLocalizations.of(context)!.createNewAccount,
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
                  labelText: AppLocalizations.of(context)!.name,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: emailController,
                  isPassword: false,
                  labelText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: passwordController,
                  labelText: AppLocalizations.of(context)!.password,
                  isPassword: true,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: confirmPasswordController,
                  labelText: AppLocalizations.of(context)!.confirmPassword,
                  isPassword: true,
                ),

                const SizedBox(height: 30),

                // Sign up button
                CustomElevatedButtomWidget(
                  width: 120,
                  text: AppLocalizations.of(context)!.register,
                  onPressed: () async {
                    try {
                      if (!isValid(context)) {
                        return;
                      }
                      final user = User(
                          id: null,
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          createdAt: null,
                          isAdmin: null);
                      final loginViewModel = context.read<UserViewModel>();
                      bool success = await loginViewModel.signUp(user);
                      if (success) {
                        final loginViewModel = context.read<UserViewModel>();
                        loginViewModel.setCurrentUser(user);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavBar()),
                          (Route<dynamic> route) => false,
                        );
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
                  text: AppLocalizations.of(context)!.alreadyHaveAccount,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
