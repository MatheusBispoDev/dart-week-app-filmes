import 'package:dart_week/models/genre_model.dart';
import 'package:dart_week/repositories/genres/genres_reposiroty.dart';
import './genres_service.dart';

class GenresServiceImpl implements GenresService {
  final GenresReposiroty _genresReposiroty;

  GenresServiceImpl({required GenresReposiroty genresReposiroty})
      : _genresReposiroty = genresReposiroty;

  @override
  Future<List<GenreModel>> getGenres() => _genresReposiroty.getGenres();
}
