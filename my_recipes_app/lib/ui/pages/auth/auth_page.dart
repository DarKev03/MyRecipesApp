import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/auth/sign_up_page.dart';
import 'package:my_recipes_app/ui/widgets/app_image_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_buttom.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class Authpage extends StatelessWidget {
  void moveToSignUpPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ));
  }

  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),

                // Nombre de la app
                const Text(
                  'MyRecipes',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // Icono de la app
                const AppImageWidget(),

                SizedBox(
                  height: 75,
                ),

                //Subtitulo
                const Text(
                  'Tu app de recetas personalizadas',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryColor,
                  ),
                ),

                SizedBox(
                  height: 40,
                ),

                //Sign up button
                CustomElevatedButtomWidget(
                  text: "Sign up",
                  onPressed: () {
                    moveToSignUpPage(context);
                  },
                ),

                SizedBox(
                  height: 10,
                ),
                //Sign in button
                CustomTextButtom(text: "Sign in", onPressed: () {}),
              ],
            ),
          ),
        ));
  }
}
