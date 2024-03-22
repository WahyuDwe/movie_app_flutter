import 'package:dartz/dartz.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<ServerFailure, List<Movie>>> call(String query) async {
    return await repository.searchMovies(query);
  }
}
