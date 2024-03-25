import 'package:dartz/dartz.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/repositories/movie_repository.dart';
import 'package:movie_apps/domain/usecases/movie_usecase.dart';

class MovieUseCaseImpl extends MovieUseCase {
  final MovieRepository repository;

  MovieUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    return await repository.getPopularMovies();
  }

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovie() async {
    return await repository.getTrendingMovie();
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    return await repository.searchMovies(query);
  }

}