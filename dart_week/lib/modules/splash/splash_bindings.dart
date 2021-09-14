import 'package:dart_week/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController()); // Linkando com o controller (put -> Criando a instância)
  }
   
}