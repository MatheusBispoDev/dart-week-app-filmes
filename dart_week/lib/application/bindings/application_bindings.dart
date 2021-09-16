import 'package:dart_week/application/auth/auth_service.dart';
import 'package:dart_week/repositories/login/login_repository.dart';
import 'package:dart_week/repositories/login/login_repository_impl.dart';
import 'package:dart_week/rest_client/rest_client.dart';
import 'package:dart_week/services/login/login_service.dart';
import 'package:dart_week/services/login/login_service_impl.dart';
import 'package:get/get.dart';

class ApplicationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestClient());
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(), fenix: true);
    // fenix : true o Get não mata a instância, mesmo não sendo usado ele continua com ela
    Get.lazyPut<LoginService>(
        () => LoginServiceImpl(loginRepository: Get.find()),
        fenix: true);
    Get.put(AuthService()).init();
  }
}
