import 'package:flutter/material.dart';
import 'package:my_recipes_app/l10n/app_localizations.dart';
import 'package:my_recipes_app/ui/pages/auth/auth_page.dart';
import 'package:my_recipes_app/ui/pages/main/admin_page.dart';
import 'package:my_recipes_app/ui/pages/main/creation_page.dart';
import 'package:my_recipes_app/ui/widgets/carousel_slider_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_gridBuilder_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            Builder(
              builder: (context) {
                final user = context.watch<UserViewModel>().currentUser;
                return PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  iconColor: AppColors.secondaryColor,
                  itemBuilder: (menuContext) {
                    final items = <PopupMenuEntry<String>>[];
                    if (user != null && user.isAdmin == true) {
                      items.add(
                        PopupMenuItem<String>(
                          value: 'admin',
                          child: Row(
                            children: [
                              const Icon(Icons.admin_panel_settings,
                                  color: AppColors.secondaryColor),
                              const SizedBox(width: 10),
                              Text('Admin',
                                  style: const TextStyle(
                                      color: AppColors.secondaryColor)),
                            ],
                          ),
                        ),
                      );
                    }
                    items.add(
                      PopupMenuItem<String>(
                        value: 'logout',
                        child: Row(
                          children: [
                            const Icon(Icons.logout,
                                color: AppColors.secondaryColor),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.logout,
                                style: const TextStyle(
                                    color: AppColors.secondaryColor)),
                          ],
                        ),
                      ),
                    );
                    return items;
                  },
                  onSelected: (value) {
                    if (value == 'admin') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminPage()),
                      );
                    }
                    if (value == 'logout') {
                      final loginViewModel = context.read<UserViewModel>();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Authpage()));
                      loginViewModel.logout();
                    }
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          elevation: 2,
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreationPage()));
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  AppLocalizations.of(context)!.recentlyAdded,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              //Carrusel de imagenes
              CarouselSliderWidget(),

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  AppLocalizations.of(context)!.favoriteRecipes,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              // Cards de recetas favoritas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: CustomGridBuilderWidget(
                  index: 1,
                ),
              )
            ],
          ),
        ));
  }
}
