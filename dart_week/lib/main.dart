import 'package:dart_week/modules/splash/splash_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Executa alguns componentes antes de iniciar o app
  await Firebase.initializeApp();
  RemoteConfig.instance.fetchAndActivate(); // Guarda uma chave importante para o aplicativo
  //RemoteConfig.instance.getString('api_token') // Acessando as chaves pelo nome
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        ...SplashModule().routers, // ... = Destruir o array de SplashModule e adicionar no array de getPages
      ],
    );
  }
}
