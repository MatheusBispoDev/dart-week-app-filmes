import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_week/models/movie_detail_model.dart';
import 'package:dart_week/models/movie_model.dart';
import 'package:dart_week/rest_client/rest_client.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import './movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final RestClient _restClient;

  MoviesRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final String url = '/movie/popular';

    final result =
        await _restClient.get<List<MovieModel>>(url, query: <String, String>{
      'api_key': RemoteConfig.instance.getString('api_token'),
      'locale': 'pt-br',
      'page': '1',
    }, decoder: (data) {
      final results = data['results'];
      if (results != null) {
        return results
            .map<MovieModel>((date) => MovieModel.fromMap(date))
            .toList();
      }
      return <MovieModel>[];
    });

    if (result.hasError) {
      print('Erro ao buscar popular movies [${result.statusText}]');
      throw Exception('Erro ao buscar filmes populares');
    }
    return result.body ?? <MovieModel>[];
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final String url = '/movie/top_rated';

    final result =
        await _restClient.get<List<MovieModel>>(url, query: <String, String>{
      'api_key': RemoteConfig.instance.getString('api_token'),
      'locale': 'pt-br',
      'page': '1',
    }, decoder: (data) {
      final results = data['results'];
      if (results != null) {
        return results
            .map<MovieModel>((date) => MovieModel.fromMap(date))
            .toList();
      }
      return <MovieModel>[];
    });

    if (result.hasError) {
      print('Erro ao buscar top rated [${result.statusText}]');
      throw Exception('Erro ao buscar Top filmes');
    }
    return result.body ?? <MovieModel>[];
  }

  @override
  Future<MovieDetailModel?> getDetail(int id) async {
    final String url = '/movie/$id';

    final result = await _restClient.get<MovieDetailModel>(
      url,
      query: {
        'api_key': RemoteConfig.instance.getString('api_token'),
        'language': 'pt-br',
        'append_to_response': 'images,credits',
        'include_image_language': 'en,pt-br'
      },
      decoder: (data) {
        return MovieDetailModel.fromMap(data);
      },
    );

    if (result.hasError) {
      print('Erro ao buscar detalhes do filme [${result.statusText}]');
      throw Exception('Erro ao buscar detalhes do filme');
    }

    return result.body;
  }

  @override
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie) async {
    try {
      var favoriteCollection = FirebaseFirestore.instance
          .collection('favorities')
          .doc(userId)
          .collection('movies');

      if (movie.favorite) {
        // Adiciona um json no banco de dados
        favoriteCollection.add(movie.toMap());
      } else {
        // Pega o primeiro e único json adicionado pra aquele filme e deleta
        var favoriteData = await favoriteCollection
            .where('id', isEqualTo: movie.id)
            .limit(1)
            .get();
        favoriteData.docs.first.reference.delete();
        /*var docs = favoriteData.docs;
        for (var doc in docs){
          doc.reference.delete();
        }*/
      }
    } on Exception catch (e, s) {
      print(e);
      print(s);
      print('Erro ao favoritar um filme');
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getFavoritiesMovies(String userId) async {
    var favoritiesMovies = await FirebaseFirestore.instance.collection('favorities').doc(userId).collection('movies').get();

    final listFavorities = <MovieModel>[];

    for (var movie in favoritiesMovies.docs){
      listFavorities.add(MovieModel.fromMap(movie.data()));
    }

    return listFavorities;
  }
}
