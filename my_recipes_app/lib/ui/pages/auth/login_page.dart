import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/user.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';
import 'package:my_recipes_app/ui/pages/auth/sign_up_page.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_scaffold_messenger.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_buttom.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/navbar.dart';
import 'package:my_recipes_app/viewmodels/home_page_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserRepository userRepository = UserRepository();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 140),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Login to your account",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryColor,
                  ),
                ),

                const SizedBox(height: 30),

                // Formularios
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
                  enableSuggestions: false,
                ),

                const SizedBox(height: 25),

                // Boton de inicio de sesion
                CustomElevatedButtomWidget(
                  width: 120,
                  text: "Login",
                  onPressed: () async {
                    try {
                      User user = User(
                        id: null,
                        name: null,
                        createdAt: null,
                        isAdmin: null,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      final loginViewModel = context.read<LoginViewModel>();
                      bool loginSuccess = await loginViewModel.login(
                        user,
                      );
                      if (loginSuccess) {
                        final homePageViewmodel =
                            context.read<HomePageViewModel>();
                        await homePageViewmodel
                            .fetchRecipesByUser(loginViewModel.currentUser!);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavBar()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        // Manejar error de inicio de sesión
                        CustomSnackbar.show(
                          context,
                          "Invalid email or password",
                        );
                      }
                    } catch (e) {}
                  },
                ),
                const SizedBox(height: 5),

                CustomTextButtom(
                    text: "Don't have an account?",
                    textSize: 13,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ));
                    }),

                const SizedBox(height: 25),

                Text("Or continue with"),

                const SizedBox(height: 15),

                // Botones de inicio de sesion con redes sociales
                IconButton(
                  icon: Image.asset(
                    "lib/assets/images/google_png.webp",
                    width: 50,
                    height: 50,
                  ),
                  onPressed: () {},
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
