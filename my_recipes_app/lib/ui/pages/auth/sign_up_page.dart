import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_buttom.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

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
                  controller: usernameController,
                  labelText: 'Username',
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: usernameController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: usernameController,
                  labelText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: usernameController,
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 30),

                // Sign up button
                CustomElevatedButtomWidget(
                  text: "Sign up",
                  onPressed: () {},
                ),

                const SizedBox(height: 15),

                Text("Or continue with"),

                const SizedBox(height: 15),

                // Boton de google
                

                // Login
                CustomTextButtom(
                  textSize: 12,
                  text: "Already have an account?",
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
