import 'package:dart_week/application/auth/auth_service.dart';
import 'package:dart_week/models/movie_model.dart';
import 'package:dart_week/services/movies/movies_service.dart';
import 'package:get/get.dart';

class FavoritiesController extends GetxController {
  final MoviesService _moviesService;
  final AuthService _authService;

  var movies = <MovieModel>[].obs;

  FavoritiesController({
    required MoviesService moviesService,
    required AuthService authService,
  })  : _moviesService = moviesService,
        _authService = authService;

  @override
  Future<void> onReady() async {
    super.onReady();
    _getFavorities();
  }

  Future<void> _getFavorities() async {
    var user = _authService.user;
    if (user != null) {
      var favorities = await _moviesService.getFavoritiesMovies(user.uid);
      movies.assignAll(favorities);
    }
  }

  Future<void> removeFavorite({required MovieModel movie}) async {
    var user = _authService.user;
    if (user != null) {
      await _moviesService.addOrRemoveFavorite(
          user.uid, movie.copyWith(favorite: false));
      movies.remove(movie);
    }
  }
}
