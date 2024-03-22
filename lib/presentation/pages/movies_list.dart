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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 8.0,
        bottom: 32.0,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie);
      },
    );
  }
}
