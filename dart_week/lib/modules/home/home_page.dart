import 'package:dart_week/application/ui/filmes_app_icons_icons.dart';
import 'package:dart_week/modules/favorites/favorites_page.dart';
import 'package:dart_week/modules/home/home_controller.dart';
import 'package:dart_week/modules/movies/movies_binginds.dart';
import 'package:dart_week/modules/movies/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:dart_week/application/ui/theme_extensions.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          selectedItemColor: context.themeRed,
          unselectedItemColor: Colors.grey,
          currentIndex: controller.pageIndex,
          onTap: controller.goToPage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Filmes'),
            BottomNavigationBarItem(
                icon: Icon(FilmesAppIcons.heart_empty), label: 'Favoritos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout_outlined), label: 'Sair'),
          ],
        );
      }),
      // Navigator 2.0 => Só altera a parte do body, ou seja, a navegação é somente nessa parte
      body: Navigator(
        key: Get.nestedKey(HomeController.NAVIGATOR_KEY),
        initialRoute: '/movies',
        onGenerateRoute: (settings) {
          if (settings.name == '/movies') {
            return GetPageRoute(
              settings: settings,
              page: () => MoviesPage(),
              binding: MoviesBinginds(),
            );
          }
          if (settings.name == '/favorites') {
            return GetPageRoute(
              settings: settings,
              page: () => FavoritesPage(),
            );
          }

          return null;
        },
      ),
    );
  }
}
