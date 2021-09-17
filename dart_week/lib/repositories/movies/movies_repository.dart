import 'package:dart_week/models/movie_detail_model.dart';
import 'package:dart_week/models/movie_model.dart';

abstract class MoviesRepository {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailModel?> getDetail(int id);
}