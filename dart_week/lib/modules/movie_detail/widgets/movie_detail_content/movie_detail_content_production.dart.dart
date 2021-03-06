import 'package:dart_week/models/movie_detail_model.dart';
import 'package:flutter/material.dart';

class MovieDetailContentProduction extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContentProduction({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
          text: 'Produtora(s): ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF222222),
          ),
          children: [
            TextSpan(
              text: movie?.productionCompanies.join(', ') ?? '',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Color(0xFF222222),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
