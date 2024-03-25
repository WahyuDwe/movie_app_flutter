import 'package:dartz/dartz.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/domain/entities/movie.dart';

abstract class MovieUseCase {
  Future<Either<Failure, List<Movie>>> getTrendingMovie();

  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  Future<Either<Failure, List<Movie>>> getPopularMovies();
}
