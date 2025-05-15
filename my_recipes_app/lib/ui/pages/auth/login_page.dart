import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/auth/sign_up_page.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_buttom.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  controller: TextEditingController(),
                  isPassword: false,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: TextEditingController(),
                  labelText: 'Password',
                  isPassword: true,
                  enableSuggestions: false,
                ),

                const SizedBox(height: 25),

                // Boton de inicio de sesion
                CustomElevatedButtomWidget(
                  width: 120,
                  text: "Login",
                  onPressed: () {},
                ),
                const SizedBox(height: 30),

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

                CustomTextButtom(
                    text: "Don't have an account?",
                    textSize: 12,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
