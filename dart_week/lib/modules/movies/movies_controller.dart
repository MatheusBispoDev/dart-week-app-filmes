import 'package:dart_week/application/ui/messages/messages_mixin.dart';
import 'package:dart_week/models/genre_model.dart';
import 'package:dart_week/services/login/genres/genres_service.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController with MessagesMixin {
  final GenresService _genresService;
  final _message = Rxn<MessageModel>();
  final genres = <GenreModel>[].obs;

  MoviesController({required GenresService genresService})
      : _genresService = genresService;

  //List<GenreModel> get genres => genres;

  @override
  void onInit() {
    super.onInit();
    messageListener(_message);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      final genres = await _genresService.getGenres();
      // Vai buscar os dados e vai sobreescrever os dados da lista (genres) - assignAll - GetX
      this.genres.assignAll(
          genres);
    } on Exception catch (e) {
      print(e);
      _message(MessageModel.error(
          title: 'Error', message: 'Error ao buscar Categorias'));
    }
  }
}
