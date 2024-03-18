import 'package:movie_apps/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovie();
  Future<List<Movie>> searchMovies(String query);
  Future<List<Movie>> getPopularMovies();
}
