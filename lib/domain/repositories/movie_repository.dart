import 'package:dartz/dartz.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<ServerFailure, List<Movie>>> getTrendingMovie();
  Future<Either<ServerFailure, List<Movie>>> searchMovies(String query);
  Future<Either<ServerFailure, List<Movie>>> getPopularMovies();
}
