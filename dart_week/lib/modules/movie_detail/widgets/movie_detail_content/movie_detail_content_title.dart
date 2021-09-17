import 'package:dart_week/application/ui/theme_extensions.dart';
import 'package:dart_week/models/movie_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class MovieDetailContentTitle extends StatelessWidget {
  final MovieDetailModel? movie;

  const MovieDetailContentTitle({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double stars = (movie?.stars ?? 1) / 2;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            movie?.title ?? '',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          RatingStars(
            value: stars,
            valueLabelVisibility: false,
            starColor: context.themeOrange,
            starSize: 14,
          ),
          SizedBox(height: 10),
          Text(
            movie?.genres.map((genre) => genre.name).join(', ') ?? '',
            style: TextStyle(fontSize: 11, color: context.themeGrey),
          ),
        ],
      ),
    );
  }
}