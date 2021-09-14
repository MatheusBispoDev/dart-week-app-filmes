import 'package:dart_week/application/ui/loader/loader_mixin.dart';
import 'package:get/get.dart';

// Dupla herança com with
class LoginController extends GetxController with LoaderMixin {

  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
  }

  Future<void> login() async {
    loading(true); // callable class = Quando podemos chamar a classe como se fosse um método 
    await 2.seconds.delay(); //await Future.delayed(Duration(seconds: 2));
    loading(false);
  }
}
