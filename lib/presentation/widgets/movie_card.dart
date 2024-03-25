import 'package:flutter/material.dart';
import 'package:movie_apps/core/utils/constant.dart';
import 'package:movie_apps/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(this.movie, {super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Image.network(
          Constant.BASE_IMAGE_URL + movie.posterPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
