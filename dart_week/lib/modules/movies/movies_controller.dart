import 'package:dart_week/application/auth/auth_service.dart';
import 'package:dart_week/application/ui/messages/messages_mixin.dart';
import 'package:dart_week/models/genre_model.dart';
import 'package:dart_week/models/movie_model.dart';
import 'package:dart_week/services/genres/genres_service.dart';
import 'package:dart_week/services/movies/movies_service.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController with MessagesMixin {
  final GenresService _genresService;
  final MoviesService _moviesService;
  final AuthService _authService;
  final _message = Rxn<MessageModel>();
  final genres = <GenreModel>[].obs;
  // Armazena os filmes filtrados
  final popularMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;
  // Armazena os filmes sem filtros, dessa forma não é necessário buscar no back-end novamente
  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];
  // Armazena os filtros por gênero
  final genreSelected = Rxn<GenreModel>();

  MoviesController(
      {required GenresService genresService,
      required MoviesService moviesService,
      required AuthService authService})
      : _genresService = genresService,
        _moviesService = moviesService,
        _authService = authService;

  // Será executado no início da tela
  @override
  void onInit() {
    super.onInit();
    messageListener(_message);
  }

  // Será executada quando a tela estiver carregado por completo (build)
  @override
  Future<void> onReady() async {
    final genresData = await _genresService.getGenres();
    // Vai buscar os dados e vai sobreescrever os dados da lista (genres) - assignAll - GetX
    genres.assignAll(genresData);

    super.onReady();
    await getMovies();
  }

  Future<void> getMovies() async {
    try {
      // Pega os dados
      var popularMoviesData = await _moviesService.getPopularMovies();
      var topRatedMoviesData = await _moviesService.getTopRatedMovies();
      final favorites = await getFavorites();

      popularMoviesData = popularMoviesData.map((movie) {
        if (favorites.containsKey(movie.id)) {
          return movie.copyWith(favorite: true);
        } else {
          return movie.copyWith(favorite: false);
        }
      }).toList();

      topRatedMoviesData = topRatedMoviesData.map((movie) {
        if (favorites.containsKey(movie.id)) {
          return movie.copyWith(favorite: true);
        } else {
          return movie.copyWith(favorite: false);
        }
      }).toList();

      popularMovies.assignAll(popularMoviesData);
      _popularMoviesOriginal = popularMoviesData;

      topRatedMovies.assignAll(topRatedMoviesData);
      _topRatedMoviesOriginal = topRatedMoviesData;
    } on Exception catch (e, s) {
      print(e); // Erro => Erro ocorrido
      print(s); // Stack => Caminho que o error percorreu
      _message(MessageModel.error(
          title: 'Error', message: 'Error ao carregar dados da pagina'));
    }
  }

  // Método para filtrar de acordo com o título
  void filterByName(String title) {
    if (title.isNotEmpty) {
      // where => Filtra a lista
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        // Faz uma comparação e refaz a lista se existir esse título
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        // Faz uma comparação e refaz a lista se existir esse título
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });
      print('filtro aplicado [$title]\n$newPopularMovies, $newTopRatedMovies');

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      // Se for vazio significa que não há filtro e volta para os dados originais
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
      print(
          'Sem o filtro [$_popularMoviesOriginal] e [$_topRatedMoviesOriginal]');
    }
  }

  // Método para filtrar de acordo com o genero
  void filterMoviesByGenre(GenreModel? genreFilter) {
    // Verifica se o filtro que está vindo é igual ao filtro selecionado
    // Se for igual, significa que o mesmo filtro foi retirado
    if (genreFilter?.id == genreSelected.value?.id) {
      genreFilter = null;
    }

    // Atribuir um novo genero no filtro
    genreSelected.value = genreFilter;

    // Senão for null significa que precisa ser filtrado
    if (genreFilter != null) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        // Faz uma comparação e refaz a lista se existir esse título
        return movie.genres.contains(genreFilter?.id);
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        // Faz uma comparação e refaz a lista se existir esse título
        return movie.genres.contains(genreFilter?.id);
      });

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      // Se for vazio significa que não há filtro e volta para os dados originais
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }

  Future<void> favoriteMovie(MovieModel movie) async {
    final user = _authService.user;
    if (user != null) {
      // Altera o favorite
      // CopyWith é um Design Pattern que altera somente oq muda no objeto
      var newMovie = movie.copyWith(favorite: !movie.favorite);
      await _moviesService.addOrRemoveFavorite(user.uid, newMovie);
      await getMovies();
    }
  }

  Future<Map<int, MovieModel>> getFavorites() async {
    var user = _authService.user;
    if (user != null) {
      final favorities = await _moviesService.getFavoritiesMovies(user.uid);
      return <int, MovieModel>{
        for (var fav in favorities) fav.id: fav,
      };
      /* Representação desse for dentro do map
        1: MovieModel
        2: MovieModel
        3: MovieModel
      */
    }
    return {};
  }
}
