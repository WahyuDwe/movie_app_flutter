import 'package:movie_apps/data/models/movie_model.dart';

abstract class MovieRemotedataSource {
  Future<List<MovieModel>> getTrendingMovies();

  Future<List<MovieModel>> searchMovies(String query);

  Future<List<MovieModel>> getPopularMovies();
}
