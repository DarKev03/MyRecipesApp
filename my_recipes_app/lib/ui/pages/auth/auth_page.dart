import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/auth/login_page.dart';
import 'package:my_recipes_app/ui/pages/auth/sign_up_page.dart';
import 'package:my_recipes_app/ui/widgets/app_image_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_buttom.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_recipes_app/viewmodels/locale_viewmodel.dart';
import 'package:provider/provider.dart';

class Authpage extends StatelessWidget {
  void moveToSignUpPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ));
  }

  void moveToLoginPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleViewmodel>().locale;
    String getLanguageText(Locale? locale) {
      switch (locale?.languageCode) {
        case 'es':
          return 'Español';
        case 'en':
          return 'English';
        case 'ca':
          return 'Valencià';
        default:
          return 'Idioma';
      }
    }

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            color: AppColors.backgroundColor,
            icon: const Icon(Icons.language),
            tooltip: getLanguageText(locale),
            onSelected: (value) {
              if (value == 'es') {
                context.read<LocaleViewmodel>().setLocale(const Locale('es'));
              } else if (value == 'en') {
                context.read<LocaleViewmodel>().setLocale(const Locale('en'));
              } else if (value == 'ca') {
                context.read<LocaleViewmodel>().setLocale(const Locale('ca'));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'es',
                child: Text(
                  'Español',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              PopupMenuItem(
                value: 'en',
                child: Text(
                  'English',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              PopupMenuItem(
                value: 'ca',
                child: Text(
                  'Valencià',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 140),
                // Nombre de la app
                const Text(
                  'MyRecipes',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 30),
                // Icono de la app
                const AppImageWidget(),
                SizedBox(height: 75),
                // Subtítulo
                Text(
                  AppLocalizations.of(context)!.slogan,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(height: 40),
                // Sign up button
                CustomElevatedButtomWidget(
                  text: AppLocalizations.of(context)!.register,
                  onPressed: () {
                    moveToSignUpPage(context);
                  },
                ),
                SizedBox(height: 10),
                // Sign in button
                CustomTextButtom(
                  text: AppLocalizations.of(context)!.login,
                  onPressed: () {
                    moveToLoginPage(context);
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
