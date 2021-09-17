import 'package:dart_week/application/bindings/application_bindings.dart';
import 'package:dart_week/application/ui/filmes_app_ui_config.dart';
import 'package:dart_week/modules/home/home_module.dart';
import 'package:dart_week/modules/login/login_module.dart';
import 'package:dart_week/modules/movie_detail/movie_detail_module.dart';
import 'package:dart_week/modules/splash/splash_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  // Executa alguns componentes antes de iniciar o app
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa o FireBase
  await Firebase.initializeApp();

  // Guarda uma chave importante para o aplicativo
  RemoteConfig.instance.fetchAndActivate();
  //RemoteConfig.instance.getString('api_token') // Acessando as chaves pelo nome
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: FilmesAppUiConfig.title,
      initialBinding: ApplicationBindings(),
      debugShowCheckedModeBanner: false,
      theme: FilmesAppUiConfig.theme,
      getPages: [
        // ... = Destruir o array de SplashModule e adicionar no array de getPages
        ...SplashModule().routers,
        ...LoginModule().routers,
        ...HomeModule().routers,
        ...MovieDetailModule().routers,
      ],
    );
  }
}
