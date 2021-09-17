import 'package:dart_week/models/genre_model.dart';
import 'package:dart_week/rest_client/rest_client.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import './genres_reposiroty.dart';

class GenresReposirotyImpl implements GenresReposiroty {
  final RestClient _restClient;

  GenresReposirotyImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<List<GenreModel>> getGenres() async {
    final String url = '/genre/movie/list';

    // Como na httpCliente já foi adicionado a url, não precisa coloar a base novamente
    final result = await _restClient.get<List<GenreModel>>(
      url,
      query: <String, String>{
        'api_key': RemoteConfig.instance.getString('api_token'),
        'language' : 'pt-br',
      },
      decoder: (data) {
        final resultData = data['genres'];
        if (resultData != null) {
          return resultData
              .map<GenreModel>((map) => GenreModel.fromMap(map))
              .toList();
        }
        return <GenreModel>[];
      },
    );

    if (result.hasError) {
      print('Erro ao bucasr Categorias: ${result.statusText}');
      throw Exception('Erro ao buscar Categorias');
    }

    return result.body ?? <GenreModel>[];
  }
}
