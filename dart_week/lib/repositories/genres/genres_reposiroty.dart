import 'package:dart_week/models/genre_model.dart';

abstract class GenresReposiroty {
  Future<List<GenreModel>> getGenres();
}