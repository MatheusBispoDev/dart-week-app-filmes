import 'package:dart_week/application/ui/widgets/movie_card.dart';
import 'package:dart_week/models/movie_model.dart';
import 'package:dart_week/modules/movies/movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesGroup extends GetView<MoviesController> {
  final String title;
  final List<MovieModel> movies;

  const MoviesGroup({Key? key, required this.title, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 280,
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true, // Passa usar o ListView dentro de colunas
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  MovieModel movie = movies[index];
                  return MovieCard(
                    movie: movie,
                    favoriteCallback: () => controller.favoriteMovie(movie),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
