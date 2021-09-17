import 'package:dart_week/modules/movies/movies_controller.dart';
import 'package:dart_week/repositories/genres/genres_reposiroty.dart';
import 'package:dart_week/repositories/genres/genres_reposiroty_impl.dart';
import 'package:dart_week/services/genres/genres_service.dart';
import 'package:dart_week/services/genres/genres_service_impl.dart';
import 'package:get/get.dart';

class MoviesBinginds implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenresReposiroty>(
        () => GenresReposirotyImpl(restClient: Get.find()));

    Get.lazyPut<GenresService>(
        () => GenresServiceImpl(genresReposiroty: Get.find()));

    Get.lazyPut(() => MoviesController(genresService: Get.find(), moviesService: Get.find()));
  }
}
