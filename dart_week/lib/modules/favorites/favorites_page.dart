import 'package:dart_week/application/ui/widgets/movie_card.dart';
import 'package:dart_week/modules/favorites/favorities_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesPage extends GetView<FavoritiesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Meus Favoritos',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: controller.movies
                  .map(
                    (movie) => MovieCard(
                      movie: movie,
                      favoriteCallback: () => controller.removeFavorite(movie: movie),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }),
    );
  }
}
