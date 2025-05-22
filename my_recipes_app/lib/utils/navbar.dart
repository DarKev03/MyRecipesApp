import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/main/calendar_page.dart';
import 'package:my_recipes_app/ui/pages/main/home_page.dart';
import 'package:my_recipes_app/ui/pages/main/search_page.dart';
import 'package:my_recipes_app/ui/pages/main/shopping_list_page.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int _currentIndex = 0;

  // Lista de páginas para navegar
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [HomePage(), SearchPage(), CalendarPage(), ShoppingListPage()];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.backgroundColor,
          currentIndex: _currentIndex, // Controla el índice actual
          onTap: _onTabTapped, // Cambia de página al tocar
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.secondaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          enableFeedback: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
