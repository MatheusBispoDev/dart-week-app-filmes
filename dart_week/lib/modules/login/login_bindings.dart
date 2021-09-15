import 'package:dart_week/modules/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    // Só instancia quando é necessário, quando não é necessário ele só fica como uma intenção
    Get.lazyPut(() => LoginController(loginService: Get.find()));
  }
}
