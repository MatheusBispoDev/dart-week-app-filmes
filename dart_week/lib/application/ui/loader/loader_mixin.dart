import 'package:flutter/material.dart';
import 'package:get/get.dart';

// mixin = Classes que possuem restrições, ou seja, só um determinado tipo pode herdar essa classe
// Nesse caso só as classes do tipo GetxController podem herdar o LoaderMixin

mixin LoaderMixin on GetxController {
  void loaderListener(RxBool loaderRx) {
    ever<bool>(loaderRx, (loading) async {
      if (loading) {
        await Get.dialog(
          const Center(
            child: CircularProgressIndicator(),
          ),
          // Bloqueia as ações do usuário enquanto não termina de processar
          barrierDismissible: false,
        );
      } else {
        // Fecha as coisas de cima
        Get.back();
      }
    });
  }
}
