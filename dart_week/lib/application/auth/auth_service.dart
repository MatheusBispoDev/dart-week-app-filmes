import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  User? user;

  // Fica escutando as alterações de usuário
  // Caso o usuário já tenha feito o login, será redirecionado para a pagina de home
  Future<void> init() async {
    //await 2.seconds.delay();
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        this.user = user;
        if (user == null) {
          Get.offAllNamed('/login');
        } else {
          Get.offAllNamed('/home');
        }
      },
    );
  }
}
