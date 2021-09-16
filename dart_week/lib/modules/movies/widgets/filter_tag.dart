import 'package:dart_week/application/ui/theme_extensions.dart';
import 'package:dart_week/models/genre_model.dart';
import 'package:flutter/material.dart';

class FilterTag extends StatelessWidget {
  final GenreModel genreModel;
  final bool _selected;
  final Function() onPressed;

  const FilterTag({
    Key? key,
    required this.genreModel,
    bool selected = false,
    required this.onPressed,
  })  : _selected = selected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // Adiciona espaços na parte de fora do Container
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        constraints: BoxConstraints(minHeight: 30, minWidth: 100),
        decoration: BoxDecoration(
          color: _selected ? context.themeRed : Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            genreModel.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
