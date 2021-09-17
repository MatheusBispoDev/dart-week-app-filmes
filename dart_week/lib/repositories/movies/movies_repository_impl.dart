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
        var dataPrint = MovieDetailModel.fromMap(data);
        print('URL IMAGE: ${dataPrint.urlImages}');
        return MovieDetailModel.fromMap(data);
      },
    );

    if (result.hasError) {
      print('Erro ao buscar detalhes do filme [${result.statusText}]');
      throw Exception('Erro ao buscar detalhes do filme');
    }

    return result.body;
  }
}
