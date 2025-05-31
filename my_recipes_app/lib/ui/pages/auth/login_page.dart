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
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/instruction_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/shopping_list_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final UserRepository userRepository = UserRepository();

  bool loading = false;

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
                Text(
                  AppLocalizations.of(context)!.welcomeBack,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.loginToYourAccount,
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
                  labelText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  controller: passwordController,
                  labelText: AppLocalizations.of(context)!.password,
                  isPassword: true,
                  enableSuggestions: false,
                ),

                const SizedBox(height: 25),

                // Boton de inicio de sesion
                loading
                    ? const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 2,
                        backgroundColor: AppColors.backgroundColor,
                      )
                    : CustomElevatedButtomWidget(
                        width: 120,
                        text: AppLocalizations.of(context)!.login,
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
                            final loginViewModel =
                                context.read<UserViewModel>();
                            bool loginSuccess = await loginViewModel.login(
                              user,
                            );
                            if (loginSuccess) {
                              final recipeViewModel =
                                  context.read<RecipeViewModel>();
                              final instructionViewmodel =
                                  context.read<InstructionViewmodel>();
                              final ingredientViewModel =
                                  context.read<IngredientViewmodel>();
                              final shoppingListViewmodel =
                                  context.read<ShoppingListViewmodel>();
                              setState(() {
                                loading = true;
                              });

                              await recipeViewModel.fetchRecipesByUser(
                                  loginViewModel.currentUser!);
                              recipeViewModel.filterRecipes("");
                              await instructionViewmodel
                                  .fetchInstructionsByUserId(
                                      loginViewModel.currentUser!.id!);
                              await ingredientViewModel
                                  .fetchIngredientsByUserId(
                                      loginViewModel.currentUser!.id!);
                              await recipeViewModel
                                  .fetchRecipeCalendarsByUserId(
                                      loginViewModel.currentUser!.id!);
                              await shoppingListViewmodel
                                  .fetchShoppingListByUserId(
                                      loginViewModel.currentUser!.id!);

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
                                AppLocalizations.of(context)!
                                    .invalidEmailOrPassword,
                              );
                            }
                          } catch (e) {}
                        },
                      ),
                const SizedBox(height: 5),

                CustomTextButtom(
                    text: AppLocalizations.of(context)!.dontHaveAccount,
                    textSize: 13,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ));
                    }),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
