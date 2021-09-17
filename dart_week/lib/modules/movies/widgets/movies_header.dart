import 'package:dart_week/modules/movies/movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesHeader extends GetView<MoviesController> {
  const MoviesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 196,
      width: Get.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: Get.width,
            child: Image.asset(
              'assets/images/header.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: Get.width * 0.9,
              child: TextField(
                onChanged: (value) => controller.filterByName(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Procurar filmes',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, // O label desaparece quando é clicado no textfield
                  prefixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.zero, // Tira o espaço de dentro do TextField
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
