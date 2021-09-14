import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Get.offAllNamed('/login'); // Tira todas as telas da pilha e chama a tela nomeada
  }
}
