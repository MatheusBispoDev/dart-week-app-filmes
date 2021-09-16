import 'package:dart_week/application/ui/widgets/movie_card.dart';
import 'package:flutter/material.dart';

class MoviesGroup extends StatelessWidget {
  final String title;

  const MoviesGroup({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true, // Passa usar o ListView dentro de colunas
              itemCount: 10,
              itemBuilder: (context, index) {
                return MovieCard();
              },
            ),
          )
        ],
      ),
    );
  }
}
