import 'package:dart_week/modules/movies/movies_controller.dart';
import 'package:dart_week/modules/movies/widgets/filter_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesFilters extends GetView<MoviesController> {
  const MoviesFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() {
          return Row(
            children: controller.genres
                .map(
                  (genre) => FilterTag(
                    genreModel: genre,
                    selected: controller.genreSelected.value?.id == genre.id,
                    onPressed: () => controller.filterMoviesByGenre(genre),
                  ),
                )
                .toList(),
          );
        }),
      ),
    );
  }
}
