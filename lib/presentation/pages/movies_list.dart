import 'package:flutter/material.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/presentation/widgets/movie_card.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  const MoviesList({
    required this.movies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(movies.length, (index) {
          final movie = movies[index];
          return MovieCard(movie);
        }),
      ),
    );
  }
}
