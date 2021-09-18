import 'package:get/get.dart';
import 'favorities_controller.dart';

class FavoritiesBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FavoritiesController(
        authService: Get.find(), moviesService: Get.find()));
  }
}
