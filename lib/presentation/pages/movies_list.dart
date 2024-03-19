import 'package:flutter/material.dart';
import 'package:movie_apps/domain/entities/movie.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  const MoviesList({
    required this.movies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(movies.length);
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Text(movie.title),
          subtitle: Text(movie.overview),
        );
      },
    );
  }
}
